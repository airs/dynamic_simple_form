require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class TimeInput < Base
      def column
        :time_value
      end

      def value_text(field_value)
        I18n.l(field_value.value, format: :time_input_value)
      end
    end
  end
end
