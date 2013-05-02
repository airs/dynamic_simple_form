require 'dynamic_simple_form/input/string_base'

module DynamicSimpleForm
  module Input
    class UrlInput < StringBase
      def input_as
        'url'
      end

      def validate_string_value(field_value)
        unless valid_url?(field_value.value)
          field_value.errors.add(column, :invalid)
        end
      end

      def valid_url?(string)
        uri = URI.parse(string)
        uri.scheme.in?('http', 'https') && uri.host.present?
      rescue URI::InvalidURIError
        false
      end
    end
  end
end
