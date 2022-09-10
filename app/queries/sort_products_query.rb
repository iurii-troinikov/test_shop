class SortProductsQuery < ApplicationQuery

  def initialize(products, params)
    @products = products
    @params = params
  end

  def call
    @products = sort_by_price
    @products = sort_by_categories
  end

  private

  def sort_by_price
    @products = @products.order(price: @params[:price]) if @params[:price].present?
    @products = @products.where('price >= ?', @params[:min_price]) if @params[:min_price].present?
    @products = @products.where('price <= ?', @params[:max_price]) if @params[:max_price].present?

    @products
  end

  def sort_by_categories
    return @products unless @params[:categories]

    @products.joins(:categories).where(categories: { id: @params[:categories]})
  end
end
