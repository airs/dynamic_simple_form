require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class BooleanInput < Base
      def column
        :boolean_value
      end

      def value_text(field_value)
        I18n.t(field_value.value.to_s)
      end
    end
  end
end
