class Category < ApplicationRecord
  has_many :product_categories
  has_many :products, through: :product_categories
  validates :products, uniqueness: { scope: :category_id }
end
