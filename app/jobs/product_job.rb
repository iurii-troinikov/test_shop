class ProductJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    1000.times do
      Product.create(title: Faker::Commerce.product_name, price: rand(10..10_000), user: User.first)
    end
  end
end
