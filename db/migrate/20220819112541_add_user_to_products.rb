class AddUserToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :user, foreign_key: true

    Product.update_all(user_id: User.first.id)
  end
end
