require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class SelectiveBase < StringBase
      def validate_string_value(field_value)
        unless field_value.field.option_values.include?(field_value.value)
          field_value.errors.add(column, :inclusion)
        end
      end
    end
  end
end
