require 'dynamic_simple_form/input/selective_base'

module DynamicSimpleForm
  module Input
    class TimeZoneInput < StringBase
      def input_as
        'time_zone'
      end

      def validate_string_value(field_value)
        unless Time.find_zone(field_value.value)
          field_value.errors.add(column, :inclusion)
        end
      end
    end
  end
end
