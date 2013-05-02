# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::TimeZoneInput do
  describe 'validations' do
    include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

    subject { build_value('Tokyo') }

    it_should_behave_like 'DynamicSimpleForm::Input::StringBase'
    it_should_behave_like 'validを受け入れinvalidを受け入れない', valid: ['Tokyo', 'American Samoa'], invalid: %w[a tokyo]
  end
end
