# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::TelInput do
  describe 'validations' do
    include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

    subject { build_value('000-0000') }

    it_should_behave_like 'DynamicSimpleForm::Input::StringBase'

    ['000-000-0000', '+0', '-0', '(053)-522-9487', '+81-53-522-9487', '522 9487'].each do |valid_value|
      it "#{valid_value.inspect}は有効" do
        should allow_value(valid_value).for(:string_value)
      end
    end

    %w[aaa-aaa-aaaa 0+ 0+0 0-].each do |invalid_value|
      it "#{invalid_value.inspect}は無効" do
        should_not allow_value(invalid_value).for(:string_value)
      end
    end
  end
end
