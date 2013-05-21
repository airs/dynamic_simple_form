module DynamicSimpleForm
  module Root
    extend ActiveSupport::Concern

    included do
      validate :validate_missing_value
    end

    def validate_missing_value
      return unless dynamic_value_type

      dynamic_value_type.fields.where(required: true).each do |field|
        value = values.find { |v| v.field == field }
        if value.nil?
          errors.add(:values, :blank)
          return
        end
      end
    end

    def dynamic
      values.each_with_object(HashWithIndifferentAccess.new) do |value, hash|
        hash[value.field.name] = value.value
      end
    end

    def method_missing(name, *args, &block)
      field = find_type_field(name)
      return super if field.nil?

      define_singleton_method name do
        values.find { |value| value.field_id == field.id }.try(:value)
      end
      send(name)
    end

    # TODO respond_to?, respond_to_missing?

    def find_type_field(name)
      dynamic_value_type && dynamic_value_type.fields.find { |field| field.name == name.to_s }
    end
  end
end
