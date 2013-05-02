require 'dynamic_simple_form/input/string_input'
require 'dynamic_simple_form/input/email_input'
require 'dynamic_simple_form/input/url_input'
require 'dynamic_simple_form/input/tel_input'
require 'dynamic_simple_form/input/boolean_input'
require 'dynamic_simple_form/input/text_input'
require 'dynamic_simple_form/input/integer_input'
require 'dynamic_simple_form/input/float_input'
require 'dynamic_simple_form/input/decimal_input'
require 'dynamic_simple_form/input/datetime_input'
require 'dynamic_simple_form/input/date_input'
require 'dynamic_simple_form/input/time_input'
require 'dynamic_simple_form/input/select_input'
require 'dynamic_simple_form/input/radio_buttons_input'
require 'dynamic_simple_form/input/time_zone_input'

module DynamicSimpleForm
  module Input
    ALL_INPUTS = [
        StringInput.instance,
        EmailInput.instance,
        UrlInput.instance,
        TelInput.instance,
        BooleanInput.instance,
        TextInput.instance,
        IntegerInput.instance,
        FloatInput.instance,
        DecimalInput.instance,
        DatetimeInput.instance,
        DateInput.instance,
        TimeInput.instance,
        SelectInput.instance,
        RadioButtonsInput.instance,
        TimeZoneInput.instance,
    ]
  end
end
