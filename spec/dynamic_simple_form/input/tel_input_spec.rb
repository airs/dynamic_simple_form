# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::TelInput do
  include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

  describe 'validations' do
    subject { build_value('000-0000') }

    it_should_behave_like 'DynamicSimpleForm::Input::StringBase'
    it_should_behave_like 'validを受け入れinvalidを受け入れない',
                          valid: ['000-000-0000', '+0', '-0', '(053)-522-9487', '+81-53-522-9487', '522 9487'],
                          invalid: %w[aaa-aaa-aaaa 0+ 0+0 0-]
  end
end
