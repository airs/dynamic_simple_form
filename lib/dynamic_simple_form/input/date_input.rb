require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class DateInput < Base
      def column
        :date_value
      end
    end
  end
end
