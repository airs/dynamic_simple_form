# coding: utf-8
require 'spec_helper'

describe DynamicSimpleForm::Field do
  describe 'validations' do
    subject { CustomerField.new }
    let(:customer_type){ CustomerType.create!(name: 'type') }
    before { CustomerField.create!(name: 'field', label: 'label', input_as: 'text', position: 1, customer_type_id: customer_type.id) }

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
end
