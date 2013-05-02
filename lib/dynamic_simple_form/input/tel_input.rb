require 'dynamic_simple_form/input/string_base'

module DynamicSimpleForm
  module Input
    class TelInput < StringBase
      def input_as
        'tel'
      end

      def validate_string_value(field_value)
        # 数字、スペース、+-()を許可し、+は先頭のみ、-が末尾に来ない
        unless /\A\+?[\d\(\) \-]*[\d\(\) ]\z/ =~ field_value.value
          field_value.errors.add(column, :invalid)
        end
      end
    end
  end
end
