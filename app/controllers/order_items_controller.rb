class OrderItemsController < ApplicationController
  before_action :set_product

  def create
    if @order_item
      @order_item.increment!(:quantity)
    else
      @order_item = current_order.order_items.create(product_id: params[:product_id])
    end

    redirect_to root_path
    flash.alert = "#{@order_item.product.title} added to cart."
  end

  def update
    value = params[:method] == 'increment' ? 1 : -1
    @order_item.increment(:quantity, value)

    if @order_item.save
      flash[:alert] = 'Updated'
    else
      flash[:alert] = @order_item.errors.full_messages[0]
    end
  end

  # def update
  # @order_item.update(quantity: params[:quantity])
  # redirect_to order_path(current_order)
  # end

  def destroy
    @order_item.destroy
    redirect_to order_path(current_order)
  end

  private

  def set_product
    @order_item = current_order.order_items.find_by(product: params[:product_id])
  end
end
