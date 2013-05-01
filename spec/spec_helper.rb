require 'bundler'
require 'active_record'
Bundler.require(:test, :default)

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
ActiveRecord::Base.send(:include, DynamicSimpleForm)

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before do
    DatabaseCleaner.strategy = :transaction
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.include FactoryGirl::Syntax::Methods
end

def drop_tables(*tables)
  tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

# Migrationログを無効化
$stdout = StringIO.new

ActiveRecord::Schema.define(version: 1) do
  # rails generate dynamic_simple_form person

  create_table :person_types do |t|
    t.string :name, null: false
    t.timestamps
  end

  create_table :person_fields do |t|
    t.references :person_type, index: true, null: false
    t.string :name, null: false
    t.string :label, null: false
    t.string :input_as, null: false
    t.integer :position, null: false
    t.string :options, null: false, default: ''
    t.boolean :required, null: false, default: false

    t.timestamps
  end

  create_table :person_field_values do |t|
    t.references :person, index: true, null: false
    t.references :person_field, index: true, null: false
    t.boolean :boolean_value
    t.string :string_value
    t.text :text_value
    t.string :file_value
    t.integer :integer_value
    t.float :float_value
    t.decimal :decimal_value
    t.datetime :datetime_value
    t.date :date_value
    t.time :time_value

    t.timestamps
  end

  create_table :people do |t|
    t.references :person_type, index: true
    t.timestamps
  end
end

class PersonType < ActiveRecord::Base
end

class PersonField < ActiveRecord::Base
  include DynamicSimpleForm::Field
end

class PersonFieldValue < ActiveRecord::Base
  include DynamicSimpleForm::FieldValue
end

class Person < ActiveRecord::Base
  dynamic_simple_form
end

FactoryGirl.define do
  factory :person_type, class: 'PersonType' do
    sequence(:name) { |n| "PersonType#{n}" }
  end

  factory :person_field, class: 'PersonField' do
    person_type
    sequence(:name) { |n| "PersonField#{n}" }
    sequence(:label) { |n| "Label#{n}" }
    input_as 'string'
    sequence(:position)
  end
end
