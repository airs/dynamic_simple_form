require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class TextInput < Base
      def column
        :text_value
      end
    end
  end
end
