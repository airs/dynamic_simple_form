module DynamicSimpleForm
  module Input
    class StringInput
      def self.input_as
        'string'
      end

      def column
        :string_value
      end
    end
  end
end
