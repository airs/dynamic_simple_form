require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class StringInput < Base
      def input_as
        'string'
      end

      def column
        :string_value
      end

      def validate(field_value)
        if field_value.value.length > 255
          field_value.errors.add(column, :too_long, count: 255)
        end
      end
    end
  end
end
