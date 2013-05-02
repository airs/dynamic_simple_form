# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::FloatInput do
  include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

  describe 'validations' do
    subject { build_value('1.2') }

    it_should_behave_like 'DynamicSimpleForm::Input::Base'
    it { should validate_numericality_of(:float_value) }
    it_should_behave_like 'validを受け入れinvalidを受け入れない',
                          valid: %w[0.1 1 -1.0 +1.0 .1],
                          invalid: %w[a 0.a １ 1+1 0. 0x1 1e-1 0.0.0]
  end

  describe '#value_text' do
    subject { build_value('+.0000000000000001') }
    its(:value_text){ should == '1.0e-16' }
  end
end
