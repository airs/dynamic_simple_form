require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class BooleanInput < Base
      def input_as
        'boolean'
      end

      def column
        :boolean_value
      end
    end
  end
end
