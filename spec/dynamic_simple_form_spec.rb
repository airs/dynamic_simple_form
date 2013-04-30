require 'spec_helper'

describe DynamicSimpleForm do
  ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

  before :all do
    $stdout = StringIO.new
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
  end

  after :all do
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.drop_table(table)
    end
  end

  class MyCustomerType < ActiveRecord::Base; end
  class MyCustomerField < ActiveRecord::Base; end
  class MyCustomerFieldValue < ActiveRecord::Base; end

  class MyCustomer < ActiveRecord::Base
    include DynamicSimpleForm
    dynamic_simple_form
  end

  describe MyCustomer do
    subject { MyCustomer.new }
    it { should belong_to(:my_customer_type) }
    it { should have_many(:values).class_name('MyCustomerFieldValue') }
  end

  describe MyCustomerType do
    subject { MyCustomerType.new }
    it { should have_many(:my_customers) }
    it { should have_many(:fields).class_name('MyCustomerField') }
  end

  describe MyCustomerField do
    subject { MyCustomerField.new }
    it { should belong_to(:my_customer_type) }
    it { should have_many(:values).class_name('MyCustomerFieldValue') }
  end

  describe MyCustomerFieldValue do
    subject { MyCustomerFieldValue.new }
    it { should belong_to(:my_customer) }
    it { should belong_to(:field).class_name('MyCustomerField') }
  end
end
