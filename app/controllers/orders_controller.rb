class OrdersController < ApplicationController
  def show
    @items = current_order.order_items.order(created_at: :asc)
  end

  def update
    current_order.update(order_params)
    UserMailer.with(
      name: current_order.name,
      email: current_order.email,
      total_amount: current_order.total_amount
    ).order_created.deliver_now!
    current_order.status_ordered!

    redirect_to root_path, notice: 'Order confirmed'
  end

  def checkout; end

  private

  def order_params
    params.require(:order).permit(:name, :email, :phone, :address)
  end
end
