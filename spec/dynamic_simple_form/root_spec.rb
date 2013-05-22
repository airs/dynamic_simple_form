# coding: utf-8
require 'spec_helper'

describe DynamicSimpleForm::Root do
  describe 'validations' do
    it 'required: trueのフィールドに対応するvalueは必須' do
      type = create(:person_type)
      field = add_field(type, name: 'str', input_as: 'string', required: true)

      person = build(:person, person_type: type)
      person.should be_invalid
      person.errors[:str].should be_present

      person.values.build(person: person, field: field, string_value: 'MyString')
      person.should be_valid
    end

    it 'valuesのvalidationエラーをrootのものとして取得できる' do
      type = create(:person_type)
      int_field = add_field(type, name: 'int', input_as: 'integer')

      person = build(:person, person_type: type)
      person.values.build(person: person, field: int_field, integer_value: 'a')
      person.valid?
      person.errors[:int].should == [person.errors.generate_message(:int, :not_a_number)]
    end
  end

  describe '#dynamic' do
    it 'field.nameとvalueのHashを返す' do
      type = create(:person_type)
      str_field = add_field(type, name: 'str', input_as: 'string')
      int_field = add_field(type, name: 'int', input_as: 'integer')
      person = create(:person, person_type: type)
      set_value(person, str_field, 'MyString')
      set_value(person, int_field, 10)
      person.dynamic.should == { 'str' => 'MyString', 'int' => 10 }
      person.dynamic[:str].should == 'MyString'
    end
  end

  describe '#method_missing' do
    let(:type) do
      type = create(:person_type)
      add_field(type, name: 'str', input_as: 'string')
      add_field(type, name: 'int', input_as: 'integer')
      type
    end

    let(:person) do
      person = create(:person, person_type: type)
      set_value(person, 'str', 'MyString')
      person
    end

    it '属性としてアクセスできる' do
      person.str.should == 'MyString'
      person.should be_respond_to(:str)
      person.int.should == nil
      expect { person.notexist }.to raise_error(NoMethodError)
    end

    it 'respond_to?' do
      person.should be_respond_to_missing(:str)
      person.should_not be_respond_to_missing(:notexist)
      person.should be_respond_to(:str)
      person.should_not be_respond_to(:notexist)
    end

    it '属性として設定できる' do
      person.str = 'NewString'
      person.should be_respond_to(:str=)
      person.str.should == 'NewString'
      person.int = 10
      person.int.should == 10
      expect { person.notexist = 20 }.to raise_error(NoMethodError)
    end

    it '属性を設定してrootごと保存できる' do
      person = build(:person, person_type: type)
      person.str = 'MyString'
      person.save!
      person.reload.dynamic.should == { 'str' => 'MyString' }
    end
  end
end
