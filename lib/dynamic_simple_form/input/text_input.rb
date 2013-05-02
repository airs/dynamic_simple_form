require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class TextInput < Base
      def input_as
        'text'
      end

      def column
        :text_value
      end
    end
  end
end
