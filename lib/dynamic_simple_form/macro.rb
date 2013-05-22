module DynamicSimpleForm
  module Macro
    extend ActiveSupport::Concern

    module ClassMethods
      def dynamic_simple_form(options = {})
        root_class_name = self.name
        options.reverse_merge!(
            type_class: "#{root_class_name}Type", type_dependent: :destroy,
            field_class: "#{root_class_name}Field",
            value_class: "#{root_class_name}FieldValue"
        )
        type_class_name = options[:type_class].to_s
        type_dependent = options[:type_dependent]
        field_class_name = options[:field_class].to_s
        value_class_name = options[:value_class].to_s

        type_class = type_class_name.constantize
        field_class = field_class_name.constantize
        value_class = value_class_name.constantize

        self.class_eval do
          belongs_to type_class_name.underscore.to_sym
          alias_method :dynamic_value_type, type_class_name.underscore.to_sym
          has_many :values, class_name: value_class_name, dependent: :destroy

          define_singleton_method :value_class do
            value_class
          end
          include DynamicSimpleForm::Root
        end

        type_class.class_eval do
          has_many root_class_name.pluralize.underscore.to_sym, dependent: type_dependent
          has_many :fields, order: :position, class_name: field_class_name, dependent: :destroy

          include DynamicSimpleForm::Type
        end

        field_class.class_eval do
          belongs_to type_class_name.underscore.to_sym
          has_many :values, class_name: value_class_name, dependent: :destroy

          include DynamicSimpleForm::Field
        end

        value_class.class_eval do
          define_singleton_method :field_foreign_key do
            "#{field_class_name.underscore}_id"
          end
          belongs_to root_class_name.underscore.to_sym
          alias_method :dynamic_value_root, root_class_name.underscore.to_sym
          belongs_to :field, class_name: field_class_name, foreign_key: field_foreign_key

          validates root_class_name.underscore.to_sym, presence: true

          scope :ordered, -> { joins(:field).merge(field_class_name.constantize.ordered) }
          scope :list_items, -> { joins(:field).merge(field_class_name.constantize.list_items) }

          def field_id
            self.send(self.class.field_foreign_key)
          end

          include DynamicSimpleForm::FieldValue
        end
      end
    end
  end
end
