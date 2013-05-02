require 'dynamic_simple_form/input/string_input'
require 'dynamic_simple_form/input/integer_input'
require 'dynamic_simple_form/input/tel_input'
require 'dynamic_simple_form/input/select_input'
require 'dynamic_simple_form/input/email_input'
require 'dynamic_simple_form/input/url_input'
require 'dynamic_simple_form/input/boolean_input'
require 'dynamic_simple_form/input/text_input'
require 'dynamic_simple_form/input/float_input'
require 'dynamic_simple_form/input/decimal_input'

module DynamicSimpleForm
  module Field
    extend ActiveSupport::Concern

    INPUTS = [
        DynamicSimpleForm::Input::StringInput.instance,
        DynamicSimpleForm::Input::IntegerInput.instance,
        DynamicSimpleForm::Input::TelInput.instance,
        DynamicSimpleForm::Input::SelectInput.instance,
        DynamicSimpleForm::Input::EmailInput.instance,
        DynamicSimpleForm::Input::UrlInput.instance,
        DynamicSimpleForm::Input::BooleanInput.instance,
        DynamicSimpleForm::Input::TextInput.instance,
        DynamicSimpleForm::Input::FloatInput.instance,
        DynamicSimpleForm::Input::DecimalInput.instance,
    ]

    included do
      validates :name, presence: true, length: { maximum: 255 }, format: { with: /\A[A-Za-z_]\w*\z/ }
      validates :label, presence: true, length: { maximum: 255 }
      validates :input_as, presence: true, length: { maximum: 255 }, inclusion: INPUTS.map(&:input_as)
      validates :position, presence: true, numericality: { only_integer: true }
      validates :options, length: { maximum: 255 }

      before_validation :strip_options

      scope :ordered, -> { order('position ASC') }
      scope :list_items, -> { where(show_in_list: true) }
    end

    def strip_options
      return if options.nil?
      self.options = option_values.map(&:strip).join(',')
    end

    def option_values
      options.split(',')
    end

    def input
      INPUTS.find { |input_class| input_class.input_as == self.input_as }
    end

    def other_value_columns
      INPUTS.map(&:column).uniq - [input.column]
    end

    def validate(field_value)
      return unless input

      if required? && field_value.blank?
        field_value.errors.add(input.column, :blank)
      end

      other_value_columns.each do |other_column|
        unless field_value[other_column].nil?
          field_value.errors.add(other_column, :present)
        end
      end

      return if field_value.blank?

      input.validate(field_value)
    end
  end
end
