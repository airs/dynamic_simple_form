require 'rails'

require 'dynamic_simple_form/version'
require 'dynamic_simple_form/root'
require 'dynamic_simple_form/type'
require 'dynamic_simple_form/field'
require 'dynamic_simple_form/field_value'

module DynamicSimpleForm
  class Railtie < Rails::Railtie
    initializer 'dynamic_simple_form.insert_into_active_record' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send(:include, DynamicSimpleForm::Root)
      end
    end
  end
end
