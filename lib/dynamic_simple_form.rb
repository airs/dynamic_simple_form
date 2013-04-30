require 'dynamic_simple_form/version'

module DynamicSimpleForm
  require 'active_support/concern'
  extend ActiveSupport::Concern

  module ClassMethods
    def dynamic_simple_form(options = {})
      included_class_name = self.name
      type_class_name = options[:type_class].try(:to_s) || "#{included_class_name}Type"
      field_class_name = options[:field_class].try(:to_s) || "#{included_class_name}Field"
      value_class_name = options[:value_class].try(:to_s) || "#{included_class_name}FieldValue"

      self.class_eval do
        belongs_to type_class_name.underscore.to_sym
        has_many :values, class_name: value_class_name
      end

      type_class_name.constantize.class_eval do
        has_many included_class_name.pluralize.underscore.to_sym
        has_many :fields, class_name: field_class_name
      end

      field_class_name.constantize.class_eval do
        belongs_to type_class_name.underscore.to_sym
        has_many :values, class_name: value_class_name
      end

      value_class_name.constantize.class_eval do
        belongs_to included_class_name.underscore.to_sym
        belongs_to :field, class_name: field_class_name, foreign_key: "#{field_class_name.underscore}_id"
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
