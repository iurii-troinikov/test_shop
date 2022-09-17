class OrderItemsController < ApplicationController
  before_action :set_product

  def create
    if @order_item
      @order_item.increment!(:quantity)
    else
      @order_item = current_order.order_items.build(product_id: params[:product_id])
      @order_item.save
      session[:order_id] = @order_item.order_id unless session[:order_id]
    end

    redirect_to root_path, notice: "#{@order_item.product.title} added to cart."
  end

  def update
    value = params[:method] == 'increment' ? 1 : -1
    @order_item.increment(:quantity, value)

    if @order_item.save
      render json: @order_item.quantity, status: :ok
    else
      render json: { error: @order_item.errors.full_messages[0] }
    end
  end

  def destroy
    @order_item.destroy
    redirect_to order_path(current_order)
  end

  private

  def set_product
    @order_item = current_order.order_items.find_by(product: params[:product_id])
  end
end
