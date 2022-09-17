class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
  end

  def show
    order_items = current_order.order_items.includes(:product)
    @items = ItemsWithProductsQuery.call(order_items, order_id: current_order.id)
  end

  def edit; end

  def update
    service_result = OrderUpdateService.call(current_order, params[:status], order_params)
    session.delete(:order_id)
    # TODO: Fix redirect with turbo stream
    redirect_to root_path, alert: service_result.result
  end

  private

  def order_params
    params.permit(:full_name, :email, :phone, :address)
  end
end
