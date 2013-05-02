# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::StringInput do
  describe 'validations' do
    include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

    subject { build_value('a') }

    it_should_behave_like 'DynamicSimpleForm::Input::Base'
    it { should ensure_length_of(:string_value).is_at_most(255) }
  end
end
