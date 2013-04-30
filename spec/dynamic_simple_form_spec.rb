require 'spec_helper'

describe DynamicSimpleForm do
  ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

  before do
    $stdout = StringIO.new
    ActiveRecord::Schema.define(version: 1) do
      create_table :my_customer_types do |t|
      end

      create_table :my_customers do |t|
        t.references :my_customer_type
      end
    end
  end

  after do
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.drop_table(table)
    end
  end

  class MyCustomerType < ActiveRecord::Base; end

  class MyCustomer < ActiveRecord::Base
    include DynamicSimpleForm
    dynamic_simple_form
  end

  describe MyCustomer do
    subject { MyCustomer.new }
    it { should belong_to(:my_customer_type) }
  end

  describe MyCustomerType do
    subject { MyCustomerType.new }
    it { should have_many(:my_customers) }
  end
end
