class OrdersController < ApplicationController
  def show
    order_items = current_order.order_items.includes(:product)
    @items = ItemsWithProductsQuery.call(order_items, order_id: current_order.id)
  end

  def edit; end

  def update
    # current_order.update(order_params)
    # current_order.status_ordered!
    result = OrderUpdateService.new(current_order, order_params).call
    if result.success
      flash.alert = 'Order confirmed'
      redirect_to root_path
    else
    end
  end

  private

  def order_params
    params.permit(:full_name, :email, :phone, :address)
  end
end
