# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::TimeInput do
  include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

  describe 'validations' do
    subject { build_value('') }
    it_should_behave_like 'DynamicSimpleForm::Input::Base'
  end

  describe '#value_text' do
    subject { build_value('2013-5-2 12:45:30') }
    # TODO timeの文字列表記
  end
end
