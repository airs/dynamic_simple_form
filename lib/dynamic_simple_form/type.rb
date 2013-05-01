module DynamicSimpleForm
  module Type
    extend ActiveSupport::Concern

    included do
      validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
    end
  end
end
