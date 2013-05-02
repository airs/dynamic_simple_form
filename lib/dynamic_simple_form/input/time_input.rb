require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class TimeInput < Base
      def input_as
        'time'
      end

      def column
        :time_value
      end
    end
  end
end
