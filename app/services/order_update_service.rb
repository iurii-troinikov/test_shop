class OrderUpdateService < Patterns::Service

  def initialize(order, order_params)
    @order = order
    @order_params = order_params
  end

  def call
    if @status == 'canceled'
      @order.status_canceled!
      'Order canceled'
    else
      @order.update(@order_params)
      @order.status_ordered!

      'Order confirmed'
    end
  end
end
