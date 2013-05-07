require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class StringBase < Base
      def column
        :string_value
      end

      def validate(field_value)
        if field_value.value.length > 255
          field_value.errors.add(column, :too_long, count: 255)
        end

        return if field_value.errors.present?

        validate_string_value(field_value)
      end

      def validate_string_value(field_value)
        # override
      end
    end
  end
end
