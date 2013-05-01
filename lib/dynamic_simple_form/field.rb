module DynamicSimpleForm
  module Field
    extend ActiveSupport::Concern

    included do
      validates :name, presence: true, length: { maximum: 255 }, format: { with: /\A[A-Za-z_]\w*\z/ }
      validates :label, presence: true, length: { maximum: 255 }
      validates :position, presence: true, numericality: { only_integer: true }
      validates :options, length: { maximum: 255 }
    end
  end
end
