# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::RadioButtonsInput do
  include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'
  let(:field_attributes) { {options: 'Male,Female'} }

  describe 'validations' do
    subject { build_value('Male') }

    it_should_behave_like 'DynamicSimpleForm::Input::StringBase'
    it_should_behave_like 'validを受け入れinvalidを受け入れない', valid: %w(Male Female), invalid: %w(male Foo)
  end

  describe '#value_text' do
    subject { build_value('Male') }
    its(:value_text){ should == 'Male' }
  end
end
