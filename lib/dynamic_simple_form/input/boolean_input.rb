require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class BooleanInput < Base
      def column
        :boolean_value
      end
    end
  end
end
