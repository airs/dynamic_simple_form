module DynamicSimpleForm
  module Root
    extend ActiveSupport::Concern

    included do
      validate :validate_missing_value
      after_validation :copy_values_errors
    end

    def validate_missing_value
      return unless dynamic_value_type

      dynamic_value_type.fields.where(required: true).each do |field|
        value = values.find { |v| v.field == field }
        if value.nil?
          errors.add(field.name, :blank)
          return
        end
      end
    end

    def copy_values_errors
      values.each do |value|
        next if value.field.blank? || value.field.input.nil?
        value.errors[value.field.input.column].each do |error|
          self.errors.add(value.field.name, error)
        end
      end
    end

    def dynamic
      values.each_with_object(HashWithIndifferentAccess.new) do |value, hash|
        hash[value.field.name] = value.value
      end
    end

    def method_missing(method_name, *args, &block)
      type, attribute = get_field_type_and_name(method_name)

      field = find_type_field(attribute)
      return super if field.nil?

      case type
      when :write
        define_and_write(field, args[0])
      when :read
        define_and_read(field)
      end
    end

    def get_field_type_and_name(method_name)
      if method_name.to_s.end_with?('=')
        [:write, method_name[0..-2]]
      else
        [:read, method_name]
      end
    end

    def define_and_write(field, value)
      define_singleton_method "#{field.name}=" do |set_value|
        field_value = values.find { |value| value.field_id == field.id }
        field_value = values.build(field: field) if field_value.nil?
        field_value.send("#{self.class.to_s.underscore}=", self)
        field_value.value = set_value
      end
      send("#{field.name}=", value)
    end

    def define_and_read(field)
      define_singleton_method field.name do
        values.find { |value| value.field_id == field.id }.try(:value)
      end
      send(field.name)
    end

    def respond_to_missing?(method_name, include_private = false)
      *, field_name = get_field_type_and_name(method_name)
      !!find_type_field(field_name) || super
    end

    def find_type_field(name)
      dynamic_value_type && dynamic_value_type.fields.find { |field| field.name == name.to_s }
    end

    def column_for_attribute(name)
      s = super
      return s if s

      return unless dynamic_value_type

      field = dynamic_value_type.fields.find { |field| field.name == name }
      return unless field

      self.class.value_class.columns_hash[field.input.column.to_s]
    end
  end
end
