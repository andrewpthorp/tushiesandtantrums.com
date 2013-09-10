class ProductsController < ApplicationController
  before_filter :set_active_navigation

  # GET /products
  def index
    @category = params[:category]

    if @category
      @products = Product.tagged_with(@category).page(params[:page])
    else
      @products = Product.page(params[:page])
    end
  end

  # GET /products/:id
  def show
    @product = Product.find(params[:id])
  end

private

  def set_active_navigation
    @active_navigation = 'products'
  end

end
