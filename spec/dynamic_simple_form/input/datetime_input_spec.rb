# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::DatetimeInput do
  include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

  describe 'validations' do
    subject { build_value('2013-05-02 00:00:00') }
    its(:datetime_value) { should == Time.new(2013, 5, 2, 0, 0, 0) }

    it_should_behave_like 'DynamicSimpleForm::Input::Base'
  end

  describe '#value_text' do
    subject { build_value('2013-5-2 13:45:30') }
    its(:value_text) { should == I18n.l(Time.new(2013, 5, 2, 13, 45, 30)) }
  end
end
