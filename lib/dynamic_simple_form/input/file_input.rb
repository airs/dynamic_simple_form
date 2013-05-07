require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class FileInput < Base
      def column
        :file_value
      end
    end
  end
end
