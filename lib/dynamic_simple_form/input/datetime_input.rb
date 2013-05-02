require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class DatetimeInput < Base
      def column
        :datetime_value
      end
    end
  end
end
