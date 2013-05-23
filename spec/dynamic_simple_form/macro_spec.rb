# coding: utf-8
require 'spec_helper'

describe DynamicSimpleForm::Macro do
  context 'デフォルト設定のとき' do
    ActiveRecord::Schema.define(version: 1) do
      create_table :my_customer_types do |t|
      end

      create_table :my_customer_fields do |t|
        t.references :my_customer_type, index: true
      end

      create_table :my_customers do |t|
        t.references :my_customer_type, index: true
      end

      create_table :my_customer_field_values do |t|
        t.references :my_customer, index: true
        t.references :my_customer_field, index: true
      end
    end

    class MyCustomerType < ActiveRecord::Base; end
    class MyCustomerField < ActiveRecord::Base; end
    class MyCustomerFieldValue < ActiveRecord::Base; end

    class MyCustomer < ActiveRecord::Base
      dynamic_simple_form
    end

    describe MyCustomer do
      subject { MyCustomer.new }
      it { should belong_to(:my_customer_type) }
      it { should have_many(:values).class_name('MyCustomerFieldValue').dependent(:destroy) }
    end

    describe MyCustomerType do
      subject { MyCustomerType.new }
      it { should have_many(:my_customers).dependent(:destroy) }
      it { should have_many(:fields).class_name('MyCustomerField').dependent(:destroy) }
    end

    describe MyCustomerField do
      subject { MyCustomerField.new }
      it { should belong_to(:my_customer_type) }
      it { should have_many(:values).class_name('MyCustomerFieldValue').dependent(:destroy) }
    end

    describe MyCustomerFieldValue do
      subject { MyCustomerFieldValue.new }
      it { should belong_to(:my_customer) }
      it { should belong_to(:field).class_name('MyCustomerField') }
    end
  end

  context 'オプションでカスタマイズするとき' do
    ActiveRecord::Schema.define(version: 1) do
      create_table :custom_types do |t|
      end

      create_table :custom_fields do |t|
        t.references :custom_type, index: true
      end

      create_table :users do |t|
        t.references :custom_type, index: true
      end

      create_table :field_values do |t|
        t.references :user, index: true
        t.references :custom_field, index: true
      end
    end

    class CustomType < ActiveRecord::Base; end
    class CustomField < ActiveRecord::Base; end
    class FieldValue < ActiveRecord::Base; end

    class User < ActiveRecord::Base
      dynamic_simple_form(type_class: 'CustomType', type_dependent: :nullify,
                          field_class: CustomField,
                          value_class: 'FieldValue')
    end

    describe User do
      subject { User.new }
      it { should belong_to(:custom_type) }
      it { should have_many(:values).class_name('FieldValue') }
    end

    describe CustomType do
      subject { CustomType.new }
      it { should have_many(:users).dependent(:nullify) }
      it { should have_many(:fields).class_name('CustomField') }
    end

    describe CustomField do
      subject { CustomField.new }
      it { should belong_to(:custom_type) }
      it { should have_many(:values).class_name('FieldValue') }
    end

    describe FieldValue do
      subject { FieldValue.new }
      it { should belong_to(:user) }
      it { should belong_to(:field).class_name('CustomField') }
    end
  end
end
