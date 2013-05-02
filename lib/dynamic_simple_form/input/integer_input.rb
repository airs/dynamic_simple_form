require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class IntegerInput < Base
      def input_as
        'integer'
      end

      def column
        :integer_value
      end

      def validate(field_value)
        raw_value = field_value.value_before_type_cast.to_s

        unless parse_raw_value_as_a_number(raw_value)
          field_value.errors.add(column, :not_a_number)
          return
        end

        unless raw_value =~ /\A[+-]?\d+\Z/
          field_value.errors.add(column, :not_an_integer)
        end
      end

      def parse_raw_value_as_a_number(raw_value)
        case raw_value
          when /\A0[xX]/
            nil
          else
            begin
              Kernel.Float(raw_value)
            rescue ArgumentError, TypeError
              nil
            end
        end
      end
    end
  end
end
