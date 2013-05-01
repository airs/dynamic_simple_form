require 'spec_helper'

describe DynamicSimpleForm::Input::IntegerInput do
  describe 'validations' do
    let(:type) { create(:person_type) }
    let(:person) { create(:person, person_type: type) }
    let(:field) { add_field(type, input_as: 'integer') }

    subject { set_value(person, field, 0) }
    it { should validate_numericality_of(:integer_value).only_integer }
  end
end
