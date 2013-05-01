require 'spec_helper'

describe DynamicSimpleForm::Type do
  describe 'validations' do
    subject { CustomerType.new }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should ensure_length_of(:name).is_at_most(255) }
  end
end
