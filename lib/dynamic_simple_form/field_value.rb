module DynamicSimpleForm
  module FieldValue
    extend ActiveSupport::Concern

    included do
      validate :validate_field
    end

    def value
      self.send(field.input.column)
    end

    def value_before_type_cast
      self.send("#{field.input.column}_before_type_cast")
    end

    def validate_field
      # TODO fieldのvalidate
      field.validate(self)
    end

    def blank?
      field.input.value_blank?(self)
    end
  end
end
