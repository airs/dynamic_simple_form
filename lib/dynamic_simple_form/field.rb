require 'dynamic_simple_form/input/string_input'

module DynamicSimpleForm
  module Field
    extend ActiveSupport::Concern

    INPUTS = [
        DynamicSimpleForm::Input::StringInput
    ]

    included do
      validates :name, presence: true, length: { maximum: 255 }, format: { with: /\A[A-Za-z_]\w*\z/ }
      validates :label, presence: true, length: { maximum: 255 }
      validates :input_as, presence: true, length: { maximum: 255 }
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
      INPUTS.find { |input_class|
        input_class.input_as == self.input_as
      }.try(:new)
    end
  end
end
