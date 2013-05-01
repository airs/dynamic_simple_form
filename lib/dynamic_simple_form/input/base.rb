module DynamicSimpleForm
  module Input
    class Base
      def value_blank?(field_value)
        field_value.value.blank?
      end

      def validate(field_value)
        # override
      end
    end
  end
end
