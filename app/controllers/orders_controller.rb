class OrdersController < ApplicationController
  def show
    order_items = current_order.order_items.includes(:product).order(:created_at)
    @order_items = ItemsWithProductsQuery.call(order_items, order_id: current_order.id)

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def edit; end

  def update
    current_order.update(order_params)
    current_order.status_ordered!
    session.delete(:order_id)
    flash.alert = 'Order confirmed'
    redirect_to root_path
  end

  def cancel_order
    current_order.status_canceled!
    session.delete(:order_id)

    redirect_to root_path, notice: 'Order canceled'
  end

  private

  def order_params
    params.permit(:full_name, :email, :phone, :address)
  end
end
