# coding: utf-8
require 'spec_helper'

describe DynamicSimpleForm::Field do
  describe 'validations' do
    subject { PersonField.new }
    before { create(:person_field) }

    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_most(255) }
    it { should allow_value('foo').for(:name) }
    it { should allow_value('_1F').for(:name) }
    it { should_not allow_value('1st').for(:name) }
    it { should_not allow_value('あ').for(:name) }
    it { should_not allow_value(' foo').for(:name) }

    it { should validate_presence_of(:label) }
    it { should ensure_length_of(:label).is_at_most(255) }

    # TODO input_asについて

    it { should validate_presence_of(:position) }
    it { should validate_numericality_of(:position).only_integer }

    it { should ensure_length_of(:options).is_at_most(255) }
  end

  describe '#options' do
    it '選択肢の両端のスペースは削除される' do
      create(:person_field, options: ' Foo & Bar , Baz ').options.should == 'Foo & Bar,Baz'
    end
  end

  describe '#option_values' do
    it 'optionsを,で区切った配列を返す' do
      create(:person_field, options: 'Foo,Bar').option_values.should == %w[Foo Bar]
    end
  end

  let(:type) { create(:person_type) }

  describe '.ordered' do
    it 'position順' do
      field2 = add_field(type, position: 2)
      field1 = add_field(type, position: 1)
      PersonField.ordered.should == [field1, field2]
    end
  end

  describe '.list_items' do
    it '一覧に表示すると設定された項目のみ' do
      field1 = add_field(type, show_in_list: true)
      field2 = add_field(type, show_in_list: false)
      PersonField.list_items.should == [field1]
    end
  end
end
