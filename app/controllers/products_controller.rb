class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.last
  end

  def new
    @product = Product.new
  end

  def create; end
end
