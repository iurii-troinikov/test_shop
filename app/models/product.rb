class Product < ApplicationRecord
  belongs_to :user
  has_many :product_categories
  has_many :categories, through: :product_categories
end
