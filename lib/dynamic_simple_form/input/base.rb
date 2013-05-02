require 'singleton'

module DynamicSimpleForm
  module Input
    class Base
      include Singleton

      def input_as
        self.class.name.split('::').last.sub(/Input/, '').underscore
      end

      def value_blank?(field_value)
        field_value.value.blank?
      end

      def validate(field_value)
        # override
      end

      def value_text(field_value)
        field_value.value.to_s
      end
    end
  end
end
