require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class StringInput < Base
      def input_as
        'string'
      end

      def column
        :string_value
      end
    end
  end
end
