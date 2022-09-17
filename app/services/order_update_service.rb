class OrderUpdateService

  def initialize(order, order_params)
    @order = order
    @order_params = order_params
  end

  def call
    @order.update(@order_params)
    @order.status_ordered!

    OpenStruct.new(success: false) if @order.errors.any?
  end
end
