require 'dynamic_simple_form/input/string_base'

module DynamicSimpleForm
  module Input
    class StringInput < StringBase
      def input_as
        'string'
      end
    end
  end
end
