# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::IntegerInput do
  describe 'validations' do
    include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

    subject { build_value(0) }

    it_should_behave_like 'DynamicSimpleForm::Input::Base'
    it { should validate_numericality_of(:integer_value).only_integer }
  end
end
