require 'dynamic_simple_form/input/string_base'

module DynamicSimpleForm
  module Input
    class EmailInput < StringBase
      def validate_string_value(field_value)
        unless field_value.value.to_s =~ /^[A-Za-z0-9._%+-=]+@([A-Za-z0-9][A-Za-z0-9._%+-]*\.)+[\w][\w-]*$/
          field_value.errors.add(column, :invalid)
        end
      end
    end
  end
end
