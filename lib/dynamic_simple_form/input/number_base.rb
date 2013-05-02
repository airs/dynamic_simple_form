require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class NumberBase < Base
      def validate(field_value)
        unless valid_number?(field_value.value_before_type_cast)
          field_value.errors.add(column, :not_a_number)
        end
      end

      def valid_number?(string)
        Kernel.Float(string) && string =~ /\A[0-9\.\+\-]*\z/
      rescue ArgumentError, TypeError
        false
      end
    end
  end
end
