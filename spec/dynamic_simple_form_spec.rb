require 'spec_helper'

describe DynamicSimpleForm do
  ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

  before do
    ActiveRecord::Schema.define(version: 1) do
      create_table :tests do |t|
      end
    end
  end

  after do
    ActiveRecord::Base.connection.tables.each do |table|
      ActiveRecord::Base.connection.drop_table(table)
    end
  end

  class Test < ActiveRecord::Base
    include DynamicSimpleForm
    dynamic_simple_form
  end

  it do
  end
end
