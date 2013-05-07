# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::FileInput do
  include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

  describe 'validations' do
    subject { build_value(nil) }

    it_should_behave_like 'DynamicSimpleForm::Input::Base'

    context 'fieldがrequiredなとき' do
      let(:field_attributes) { { required: true } }
      it { should validate_presence_of(:file_value) }
    end
  end
end
