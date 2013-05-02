module DynamicSimpleForm
  module FieldValue
    extend ActiveSupport::Concern

    included do
      validates :field, presence: true
      validate :validate_field
    end

    def value
      self.send(field.input.column)
    end

    def value_before_type_cast
      self.send("#{field.input.column}_before_type_cast")
    end

    def validate_field
      return unless field

      unless dynamic_value_root.dynamic_value_type.fields.include?(self.field)
        errors.add(:field, :invalid)
        return
      end

      field.validate(self)
    end

    def blank?
      field.input.value_blank?(self)
    end

    def value_text
      field.input.value_text(self)
    end

    alias to_s value_text
  end
end
