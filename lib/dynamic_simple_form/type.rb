require 'set'

module DynamicSimpleForm
  module Type
    extend ActiveSupport::Concern

    included do
      accepts_nested_attributes_for :fields, allow_destroy: true

      validates :name, presence: true, length: { maximum: 255 }
      validate :fields_uniqueness

      before_save :normalize_fields_position
    end

    def normalize_fields_position
      fields.reject(&:marked_for_destruction?).sort_by(&:position).each_with_index do |field, index|
        field.position = index + 1
      end
    end

    def fields_uniqueness
      any_duped = %w[name label position].any? do |attribute|
        duped = fields.reject(&:marked_for_destruction?).combination(2).each_with_object(Set.new) do |(field1, field2), duped|
          duped << field1 << field2 if field1[attribute] == field2[attribute]
        end
        duped.each do |field|
          field.errors.add(attribute, :taken)
        end
        duped.present?
      end

      if any_duped
        self.errors.add(:base, :invalid)
      end
    end
  end
end
