require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class TimeInput < Base
      def column
        :time_value
      end
    end
  end
end
