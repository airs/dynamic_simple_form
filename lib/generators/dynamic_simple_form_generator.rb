require 'rails/generators/active_record'

class DynamicSimpleFormGenerator < ActiveRecord::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def create_migration
    migration_template 'migration.rb.erb', "db/migrate/create_dynamic_simple_form_#{table_name}"
  end

  def create_type_model
    template 'type_model.rb.erb', "app/models/#{file_name}_type.rb"
    template 'field_model.rb.erb', "app/models/#{file_name}_field.rb"
    template 'field_value_model.rb.erb', "app/models/#{file_name}_field_value.rb"
  end
end
