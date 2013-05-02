# coding: utf-8

shared_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる' do
  let(:type) { create(:person_type) }
  let(:person) { create(:person, person_type: type) }
  let(:field) { add_field(type, attributes_for(:person_field, input_as: described_class.instance.input_as)) }

  def build_value(value)
    person.values.build(attributes_for(:person_field_value_base, person_field_id: field.id).merge(field.input.column => value))
  end
end

shared_examples 'DynamicSimpleForm::Input::Base' do
  context 'fieldがrequiredのとき' do
    let(:field) { add_field(type, input_as: 'string', required: true) }
    it { should validate_presence_of(:string_value) }
  end

  context 'fieldがrequiredでないとき' do
    let(:field) { add_field(type, input_as: 'integer', required: false) }
    it { should_not validate_presence_of(:string_value) }
  end

  it '型に対応するフィールド以外に値が入っていたらエラー' do
    other_column = field.other_value_columns.first
    value = person.values.build(attributes_for(:person_field_value, person_field_id: field.id).merge(other_column => '1'))
    value.should be_invalid
    value.errors[other_column].should include(value.errors.generate_message(other_column, :present))
  end
end
