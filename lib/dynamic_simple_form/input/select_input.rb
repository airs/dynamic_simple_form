require 'dynamic_simple_form/input/selective_base'

module DynamicSimpleForm
  module Input
    class SelectInput < SelectiveBase
      def input_as
        'select'
      end
    end
  end
end
