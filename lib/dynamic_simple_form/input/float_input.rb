require 'dynamic_simple_form/input/number_base'

module DynamicSimpleForm
  module Input
    class FloatInput < NumberBase
      def column
        :float_value
      end
    end
  end
end
