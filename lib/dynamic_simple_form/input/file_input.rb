require 'dynamic_simple_form/input/base'

module DynamicSimpleForm
  module Input
    class FileInput < Base
      def column
        :file_value
      end

      def value_text(field_value)
        File.basename(field_value.file_value.path)
      end
    end
  end
end
