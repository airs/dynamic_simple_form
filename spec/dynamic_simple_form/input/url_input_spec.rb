# coding: utf-8
require 'spec_helper'
require_relative 'shared_context'

describe DynamicSimpleForm::Input::UrlInput do
  include_context 'descibed_classに対応するPersonFieldValueをbuild_valueで生成できる'

  describe 'validations' do
    subject { build_value('http://example.com') }

    it_should_behave_like 'DynamicSimpleForm::Input::StringBase'
    it_should_behave_like 'validを受け入れinvalidを受け入れない',
                          valid: %w[http://example.com https://example.com],
                          invalid: %w[http: http:/ http:// foobar ftp://example.com mailto:foo@bar.baz mailto:]
  end

  describe '#value_text' do
    subject { build_value('http://example.com/foo') }
    its(:value_text){ should == 'http://example.com/foo' }
  end
end
