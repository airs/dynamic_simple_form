require 'dynamic_simple_form/input/string_base'

module DynamicSimpleForm
  module Input
    class SelectInput < StringBase
      def input_as
        'select'
      end

      def validate_string_value(field_value)
        unless field_value.field.option_values.include?(field_value.value)
          field_value.errors.add(column, :inclusion)
        end
      end
    end
  end
end
