require 'dynamic_simple_form/input/selective_base'

module DynamicSimpleForm
  module Input
    class RadioButtonsInput < SelectiveBase
      def input_as
        'radio_buttons'
      end
    end
  end
end
