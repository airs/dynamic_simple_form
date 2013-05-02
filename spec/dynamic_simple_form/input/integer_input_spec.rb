# coding: utf-8
require 'spec_helper'

describe DynamicSimpleForm::Input::IntegerInput do
  describe 'validations' do
    let(:type) { create(:person_type) }
    let(:person) { create(:person, person_type: type) }
    let(:field) { add_field(type, input_as: 'integer') }

    subject { set_value(person, field, 0) }
    it { should validate_numericality_of(:integer_value).only_integer }

    context 'fieldがrequiredのとき' do
      let(:field) { add_field(type, input_as: 'integer', required: true) }
      it { should validate_presence_of(:integer_value) }
    end

    context 'fieldがrequiredでないとき' do
      let(:field) { add_field(type, input_as: 'integer', required: false) }
      it { should_not validate_presence_of(:integer_value) }
    end

    it '型に対応するフィールド以外に値が入っていたらエラー' do
      other_column = field.other_value_columns.first
      value = person.values.build(attributes_for(:person_field_value, person_field_id: field.id).merge(other_column => '1'))
      value.should be_invalid
      value.errors[other_column].should include(value.errors.generate_message(other_column, :present))
    end
  end
end
