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
        DynamicSimpleForm::Input::StringInput.instance,
        DynamicSimpleForm::Input::EmailInput.instance,
        DynamicSimpleForm::Input::UrlInput.instance,
        DynamicSimpleForm::Input::TelInput.instance,
        DynamicSimpleForm::Input::BooleanInput.instance,
        DynamicSimpleForm::Input::TextInput.instance,
        DynamicSimpleForm::Input::IntegerInput.instance,
        DynamicSimpleForm::Input::FloatInput.instance,
        DynamicSimpleForm::Input::DecimalInput.instance,
        DynamicSimpleForm::Input::DatetimeInput.instance,
        DynamicSimpleForm::Input::DateInput.instance,
        DynamicSimpleForm::Input::TimeInput.instance,
        DynamicSimpleForm::Input::SelectInput.instance,
        DynamicSimpleForm::Input::RadioButtonsInput.instance,
        DynamicSimpleForm::Input::TimeZoneInput.instance,
    ]
  end
end
