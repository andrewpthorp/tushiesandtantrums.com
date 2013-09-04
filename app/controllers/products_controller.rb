class ProductsController < ApplicationController
  before_filter :set_active_navigation

  # GET /products
  def index
    if params[:category]
      @products = Product.tagged_with(params[:category])
    else
      @products = Product.all
    end
  end

  # GET /products/:id
  def show
    @product = Product.find(params[:id])
  end

  # GET /products/:id/edit
  def edit
    @product = Product.find(params[:id])
  end

  # PUT /products/:id
  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to @product, notice: "Product successfully updated!"
    else
      flash[:error] = "There was a problem updating that product. Please make sure you filled out all of the fields"
      render :edit
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # POST /products
  def create
    @product = Product.new(params[:product])

    if @product.save
      redirect_to @product, notice: "Product successfully created!"
    else
      flash[:error] = "There was a problem creating that product. Please make sure you filled out all of the fields"
      render :new
    end
  end

  # DELETE /products/:id
  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      redirect_to products_path, notice: "Product successfully deleted!"
    else
      flash[:error] = "There was a problem deleting that Product. Please try again."
      redirect_to @product
    end
  end

private

  def set_active_navigation
    @active_navigation = 'products'
  end

end
