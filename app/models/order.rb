class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum status: %i[in_progress ordered canceled], _prefix: true

  def total_amount
    order_items.includes(:product).map(&:sub_price).sum
  end
end
