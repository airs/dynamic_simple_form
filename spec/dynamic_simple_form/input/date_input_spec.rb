# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::DateInput do
  include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

  describe 'validations' do
    subject { build_value('2013-05-02') }
    its(:date_value) { should == Date.new(2013, 5, 2) }

    it_should_behave_like 'DynamicSimpleForm::Input::Base'
  end
end
