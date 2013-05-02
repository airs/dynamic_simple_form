# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::EmailInput do
  include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

  describe 'validations' do
    subject { build_value('mail@example.com') }

    it_should_behave_like 'DynamicSimpleForm::Input::StringBase'
    it_should_behave_like 'validを受け入れinvalidを受け入れない',
                          valid: %w[foo@bar.com user+some@gmail.com],
                          invalid: %w[a foo@bar あ@foo.com]
  end

  describe '#value_text' do
    subject { build_value('mail@example.com') }
    its(:value_text){ should == 'mail@example.com' }
  end
end
