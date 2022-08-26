class Product < ApplicationRecord
  belongs_to :user

  has_many :comments, as: :commentable
  has_many :product_categories
  has_many :categories, through: :product_categories

  validates :title, presence: true
  validates :images, file_size: { less_than_or_equal_to: 4.kilobytes, message: "Please Check File Size" },
            file_content_type: { allow: %w[image/jpeg image/jpg image/png image/gif],
                                 message: "Please Check File Format"}

  has_many_attached :images do |attachable|
    attachable.variant :thumbnail, resize: "100x100"
    attachable.variant :large, resize: "250x250"
  end
end
