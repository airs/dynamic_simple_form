require 'dynamic_simple_form/version'
require 'dynamic_simple_form/type'
require 'dynamic_simple_form/field'
require 'dynamic_simple_form/field_value'

module DynamicSimpleForm
  require 'active_support/concern'
  extend ActiveSupport::Concern

  module ClassMethods
    def dynamic_simple_form(options = {})
      included_class_name = self.name
      options.reverse_merge!(
          type_class: "#{included_class_name}Type", type_dependent: :destroy,
          field_class: "#{included_class_name}Field",
          value_class: "#{included_class_name}FieldValue"
      )
      type_class_name = options[:type_class].to_s
      type_dependent = options[:type_dependent]
      field_class_name = options[:field_class].to_s
      value_class_name = options[:value_class].to_s

      self.class_eval do
        belongs_to type_class_name.underscore.to_sym
        has_many :values, class_name: value_class_name, dependent: :destroy
      end

      type_class_name.constantize.class_eval do
        has_many included_class_name.pluralize.underscore.to_sym, dependent: type_dependent
        has_many :fields, order: :position, class_name: field_class_name, dependent: :destroy

        include DynamicSimpleForm::Type
      end

      field_class_name.constantize.class_eval do
        belongs_to type_class_name.underscore.to_sym
        has_many :values, class_name: value_class_name, dependent: :destroy

        include DynamicSimpleForm::Field
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
        ActiveRecord::Base.send(:include, DynamicSimpleForm)
      end
    end
  end
end
