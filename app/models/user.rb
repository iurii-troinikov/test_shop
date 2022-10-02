class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :products, dependent: :nullify
  has_many :orders, dependent: :nullify

  validates :name, presence: true

  enum role: %i[customer admin], _prefix: true
end
