require 'dynamic_simple_form/version'

module DynamicSimpleForm
  require 'active_support/concern'
  extend ActiveSupport::Concern

  module ClassMethods
    def dynamic_simple_form
    end
  end

  require 'rails'
  class Railtie < Rails::Railtie
    initializer 'dynamic_simple_form.insert_into_active_record' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::send(:include, DynamicSimpleForm)
      end
    end
  end
end
