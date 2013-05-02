require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class DatetimeInput < Base
      def column
        :datetime_value
      end

      def value_text(field_value)
        I18n.l(field_value.value)
      end
    end
  end
end
