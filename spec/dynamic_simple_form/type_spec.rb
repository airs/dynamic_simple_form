# coding: utf-8
require 'spec_helper'

describe DynamicSimpleForm::Type do
  describe 'validations' do
    subject { PersonType.new }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should ensure_length_of(:name).is_at_most(255) }
  end

  describe '#fields_attributes' do
    it 'Nested_attributeによって一度に作成できる' do
      type = create(:person_type, fields_attributes: {
          new_0: attributes_for(:person_field)
      })
      type.should have(1).field
    end

    it '一度に追加もできる' do
      type = create(:person_type)
      expect {
        type.update_attributes(fields_attributes: [attributes_for(:person_field)])
      }.to change(type.fields, :count).by(1)
    end

    it '一度に削除もできる' do
      type = create(:person_type)
      field = type.fields.create(attributes_for(:person_field))
      expect {
        type.update_attributes(fields_attributes: { id: field.id, _destroy: '1' })
      }.to change(type.fields, :count).by(-1)
    end
  end

  describe '#fields' do
    it 'position順に並ぶ' do
      type = create(:person_type)
      [2, 1, 3].each_with_index { |position, index| type.fields.create!(attributes_for(:person_field, position: position, name: "_#{index + 1}")) }
      type.save
      type.reload.fields.order(:position).map(&:name).should == %w[_2 _1 _3]
    end

    describe 'positionの更新について' do
      let(:type) do
        create(:person_type).tap do |type|
          2.times { |n| type.fields.create!(attributes_for(:person_field, name: "_#{n + 1}", position: n + 1)) }
        end
      end

      it 'positionの入れ替えができる' do
        type.fields[0].position = 2
        type.fields[1].position = 1
        type.save.should be_true
        type.reload.fields.map(&:name).should == %w[_2 _1]
      end

      it 'positionが重複しているとエラーになる' do
        type.fields[1].position = 1
        type.save.should be_false
        type.should be_invalid
        type.fields[0].errors[:position].should be_present
        type.fields[1].errors[:position].should be_present
        type.reload.fields.map(&:position).should == [1, 2]
      end

      it 'positionは1,2,3...の数値に修正される' do
        type.fields[0].position = 4
        type.fields[1].position = 2
        type.save!
        type.reload.fields.map(&:position).should == [1, 2]
      end

      it 'positionに数字でない値が入っていたらエラーになる' do
        type.fields[1].position = 'a'
        type.save.should be_false
        type.should be_invalid
        type.reload.fields.map(&:name).should == %w[_1 _2]
        type.reload.fields.map(&:position).should == [1, 2]
      end

      it '削除するfieldはposition計算上無視される' do
        type.fields[0].mark_for_destruction
        type.fields[1].position = 1
        type.save!
        type.should have(1).field
        type.fields[0].position.should == 1
      end
    end

    describe 'nameの更新について' do
      let(:type) do
        create(:person_type).tap do |type|
          2.times { |n| type.fields.create!(attributes_for(:person_field, name: "_#{n}", position: n)) }
        end
      end

      it 'nameの入れ替えができる' do
        type.fields[0].name, type.fields[1].name = type.fields[1].name, type.fields[0].name
        type.should be_valid
        type.save.should be_true
        type.reload.fields.map(&:name).should == %w[_1 _0]
      end

      it 'nameが重複しているとエラーになる' do
        type.fields[1].name = type.fields[0].name
        type.save.should be_false
        type.fields[0].errors[:name].should be_present
        type.fields[1].errors[:name].should be_present
        type.should be_invalid
        type.reload.fields.map(&:name).should == %w[_0 _1]
      end
    end

    describe 'labelの更新について' do
      let(:type) do
        create(:person_type).tap do |type|
          2.times { |n| type.fields.create!(attributes_for(:person_field, label: "_#{n}", position: n)) }
        end
      end

      it 'labelの入れ替えができる' do
        type.fields[0].label, type.fields[1].label = type.fields[1].label, type.fields[0].label
        type.should be_valid
        type.save.should be_true
        type.reload.fields.map(&:label).should == %w[_1 _0]
      end

      it 'labelが重複しているとエラーになる' do
        type.fields[1].label = type.fields[0].label
        type.save.should be_false
        type.fields[0].errors[:label].should be_present
        type.fields[1].errors[:label].should be_present
        type.should be_invalid
        type.reload.fields.map(&:label).should == %w[_0 _1]
      end
    end
  end
end
