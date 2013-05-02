# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::StringInput do
  include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

  describe 'validations' do
    subject { build_value('a') }
    it_should_behave_like 'DynamicSimpleForm::Input::StringBase'
  end

  describe '#value_text' do
    subject { build_value('foo') }
    its(:value_text){ should == 'foo' }
  end
end
