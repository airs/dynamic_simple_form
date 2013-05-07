require 'dynamic_simple_form/input/string_base'

module DynamicSimpleForm
  module Input
    class TelInput < StringBase
      def validate_string_value(field_value)
        unless /\A\+?[\d\(\) \-]*[\d\(\) ]\z/ =~ field_value.value
          field_value.errors.add(column, :invalid)
        end
      end
    end
  end
end
