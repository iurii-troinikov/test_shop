class OrderItemsController < ApplicationController
  before_action :set_product
  before_action :set_order_items, only: %i[update destroy]

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
      respond_to do |format|
        format.turbo_stream
      end

    else
      render json: { error: @order_item.errors.full_messages[0] }
    end
  end

  def destroy
    @order_item.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_product
    @order_item = current_order.order_items.find_by(product: params[:product_id])
  end

  def set_order_items
    @order_items = ItemsWithProductsQuery.call(current_order.order_items, order_id: current_order.id).order(:created_at)
  end
end
