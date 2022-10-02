class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update]

  def index
    products = SortProductsQuery.call(Product.all, params)
    @categories = Category.all
    @pagy, @products = pagy(products)
  end

  def show
    authorize @product
  end

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

  def fetch_products
    authorize Product
    ProductJob.set(wait: 10.seconds).perform_now

    redirect_to root_path, notice: "Products was successfully created."
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price, images: [])
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
