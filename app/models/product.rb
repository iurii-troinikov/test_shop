# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :user

  has_many :comments, as: :commentable
  has_many :product_categories
  has_many :categories, through: :product_categories

  validates :title, :description, presence: true
end
