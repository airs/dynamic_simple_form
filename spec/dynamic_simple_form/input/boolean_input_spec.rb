# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::BooleanInput do
  include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

  describe 'validations' do
    subject { build_value(true) }
    it_should_behave_like 'DynamicSimpleForm::Input::Base'
  end
end
