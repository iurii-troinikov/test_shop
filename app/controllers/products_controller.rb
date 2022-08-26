class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update]

  def index
    @pagy, @products = pagy(Product.all)
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Product.find(params[:id]).destroy
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, images: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
