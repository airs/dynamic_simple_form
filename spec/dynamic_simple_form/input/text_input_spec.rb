# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::TextInput do
  include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

  describe 'validations' do
    subject { build_value('a') }
    it_should_behave_like 'DynamicSimpleForm::Input::Base'
  end

  describe '#value_text' do
    subject { build_value("foo\r\nbar\nbaz") }
    its(:value_text){ should == "foo\r\nbar\nbaz" }
  end
end
