require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class DateInput < Base
      def column
        :date_value
      end

      def value_text(field_value)
        I18n.l(field_value.value)
      end
    end
  end
end
