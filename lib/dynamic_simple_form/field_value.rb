require 'carrierwave'
require 'carrierwave/orm/activerecord'

module DynamicSimpleForm
  module FieldValue
    extend ActiveSupport::Concern

    included do
      validates :field, presence: true
      validate :validate_field
      mount_uploader :file_value, DynamicSimpleForm::FileUploader
    end

    def value
      self.send(field.input.column)
    end

    def value_before_type_cast
      self.send("#{field.input.column}_before_type_cast")
    end

    def value=(value)
      send("#{field.input.column}=", value)
    end

    def validate_field
      return unless field && dynamic_value_root

      unless dynamic_value_root.dynamic_value_type.fields.include?(self.field)
        errors.add(:field, :invalid)
        return
      end

      field.validate(self)
    end

    def blank?
      field.input.value_blank?(self)
    end
  end
end
