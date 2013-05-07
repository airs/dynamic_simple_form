require 'dynamic_simple_form/input/number_base'

module DynamicSimpleForm
  module Input
    class DecimalInput < NumberBase
      def column
        :decimal_value
      end
    end
  end
end
