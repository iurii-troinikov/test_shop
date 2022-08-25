class ProductsController < ApplicationController
  def index
    @products = Product.all
    logger.debug 'The article was saved and now the user is going to be redirected...'
  end

  def show
    @product = Product.last
  end

  def new
    @product = Product.new
  end

  def destroy
    Product.find(params[:id]).destroy
  end
end
