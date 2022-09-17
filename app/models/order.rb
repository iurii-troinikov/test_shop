class Order < ApplicationRecord
  belongs_to :user, optional: true

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum status: %i[in_progress ordered canceled], _prefix: true

  def total_price
    order_items.map(&:sub_price).flatten.sum
  end
end
