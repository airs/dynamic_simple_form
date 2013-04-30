require 'dynamic_simple_form/version'

module DynamicSimpleForm
  require 'active_support/concern'
  extend ActiveSupport::Concern

  module ClassMethods
    def dynamic_simple_form
      self_class = self

      name = self_class.name.singularize.underscore
      belongs_to :"#{name}_type"

      "#{self.name}Type".constantize.class_eval do
        has_many self_class.name.pluralize.underscore.to_sym
      end
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
