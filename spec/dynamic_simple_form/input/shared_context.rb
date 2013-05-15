# coding: utf-8

shared_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる' do
  let!(:type) { create(:person_type) }
  let!(:person) { create(:person, person_type: type) }
  let(:field) { add_field(type, attributes_for(:person_field, field_attributes.merge(input_as: described_class.instance.input_as))) }
  let(:field_attributes) { {} }

  def build_value(value)
    person.values.build(attributes_for(:person_field_value_base, person_field_id: field.id).merge(field.input.column => value))
  end
end

shared_examples 'DynamicSimpleForm::Input::Base' do
  context 'fieldがrequiredのとき' do
    let(:field_attributes) { { required: true } }
    it { should validate_presence_of(field.input.column) }
  end

  context 'fieldがrequiredでないとき' do
    let(:field_attributes) { { required: false } }
    it { should_not validate_presence_of(field.input.column) }
  end

  it '型に対応するフィールド以外に値が入っていたらエラー' do
    other_column = field.other_value_columns.first
    value = person.values.build(attributes_for(:person_field_value, person_field_id: field.id).merge(other_column => '1'))
    value.should be_invalid
    value.errors[other_column].should include(value.errors.generate_message(other_column, :present))
  end
end

shared_examples 'DynamicSimpleForm::Input::StringBase' do
  it_should_behave_like 'DynamicSimpleForm::Input::Base'
  it { should ensure_length_of(:string_value).is_at_most(255) }
end

shared_examples 'validを受け入れinvalidを受け入れない' do |options|
  options[:valid].each do |valid_value|
    it "#{valid_value.inspect}は有効" do
      should allow_value(valid_value).for(field.input.column)
    end
  end

  options[:invalid].each do |invalid_value|
    it "#{invalid_value.inspect}は無効" do
      should_not allow_value(invalid_value).for(field.input.column)
    end
  end
end
