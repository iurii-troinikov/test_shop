class RemoveNullUserIdFromOrders < ActiveRecord::Migration[7.0]
  def up
    change_column :orders, :user_id, :bigint, null: true
  end

  def down
    change_column :orders, :user_id, :bigint, null: false
  end
end
