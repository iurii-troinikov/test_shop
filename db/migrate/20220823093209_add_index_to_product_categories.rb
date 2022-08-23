class AddIndexToProductCategories < ActiveRecord::Migration[7.0]
  def change
    add_index :product_categories, [:product_id, :category_id], unique:  true
  end
end
