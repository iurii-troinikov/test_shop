class Product < ApplicationRecord
  belongs_to :user

  has_many :comments, as: :commentable
  has_many :product_categories
  has_many :categories, through: :product_categories

  validates :title, presence: true
  validates :images, file_size: { less_than_or_equal_to: 100.megabytes, message: 'Please Check File Size' },
                     file_content_type: { allow: %w[image/jpeg image/jpg image/png image/gif],
                                          message: 'Please Check File Format'}, if: -> { images.attached? }

  before_save :send_mail_about_new_price, if: :price_changed?

  has_many_attached :images do |attachable|
    attachable.variant :thumbnail, resize: '100x100'
    attachable.variant :large, resize: '250x250'
  end

  private

  def send_mail_about_new_price
    return if new_record?

    User.all.each do |user|
      ProductMailer.with(product: self, user:).price_is_changed.deliver_now
    end
  end
end
