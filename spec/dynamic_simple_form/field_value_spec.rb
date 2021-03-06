# coding: utf-8
require 'spec_helper'

describe DynamicSimpleForm::FieldValue do
  let(:type) { create(:person_type) }
  let(:person) { create(:person, person_type: type) }
  let(:field) { add_field(type, input_as: 'string') }

  describe 'validations' do
    subject { set_value(person, field, 'a') }
    it { should validate_presence_of(:field) }

    it 'typeに含まれないfieldのvalueを追加したらエラー' do
      other_type = create(:person_type)
      other_field = add_field(other_type, input_as: 'string')

      value = set_value(person, other_field, 'a')
      value.should be_invalid
      value.errors[:field].should be_present
    end

    it { should validate_presence_of(:person) }
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

  describe '#value=' do
    let!(:str_field) { add_field(type, input_as: 'string') }
    let!(:int_field) { add_field(type, input_as: 'integer') }

    it 'fieldのタイプに合わせた列に値が設定される' do
      str = person.values.build(field: str_field)
      str.value = 'str'
      str.string_value.should == 'str'

      int = person.values.build(field: int_field)
      int.value = 10
      int.integer_value.should == 10
    end
  end

  describe '#file_value' do
    let(:field) { add_field(type, input_as: 'file') }

    it 'アップロードされたファイルを処理できる' do
      value = set_value(person, field, uploaded_file)
      File.should be_exist(value.value.path)
    end

    it 'nilならfile_valueはblankになる' do
      value = set_value(person, field, nil)
      value.file_value.should be_blank
    end
  end
end
