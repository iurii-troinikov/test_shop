# frozen_string_literal: true

class ItemsWithProductsQuery < Patterns::Query
  queries OrderItem

  private

  def query
    relation.from <<~SQL.squish
      (
        SELECT
          order_items.*,
          products.title AS product_title,
          products.price AS product_price
        FROM order_items
        LEFT JOIN products
          ON products.id = order_items.product_id
        WHERE order_items.order_id = #{order_id}
      ) order_items
    SQL
  end

  def order_id
    options.fetch(:order_id)
  end
end
