# coding: utf-8
require 'spec_helper'

describe DynamicSimpleForm::FieldValue do
  let(:type) { create(:person_type) }
  let(:person) { create(:person, person_type: type) }

  describe 'validations' do
    subject { create(:person_field_value) }
    it { should validate_presence_of(:field) }
  end

  describe '.ordered' do
    it 'fieldのposition順' do
      field2 = add_field(type, position: 2)
      field1 = add_field(type, position: 1)
      value2 = set_value(person, field2, '2')
      value1 = set_value(person, field1, '1')
      PersonFieldValue.ordered.should == [value1, value2]
    end
  end

  describe '.list_items' do
    it '一覧に表示すると設定された項目の値のみ' do
      field1 = add_field(type, show_in_list: true)
      field2 = add_field(type, show_in_list: false)
      value1 = set_value(person, field1, '1')
      value2 = set_value(person, field2, '2')
      PersonFieldValue.list_items.should == [value1]
    end
  end
end
