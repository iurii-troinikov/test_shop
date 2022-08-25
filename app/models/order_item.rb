class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  def sub_price
    quantity * product.price
  end
end
