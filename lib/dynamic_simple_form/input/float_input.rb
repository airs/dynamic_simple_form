require 'dynamic_simple_form/input/number_base'

module DynamicSimpleForm
  module Input
    class FloatInput < NumberBase
      def input_as
        'float'
      end

      def column
        :float_value
      end
    end
  end
end
