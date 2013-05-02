# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::StringInput do
  describe 'validations' do
    include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

    subject { build_value('a') }

    it_should_behave_like 'DynamicSimpleForm::Input::StringBase'
  end
end
