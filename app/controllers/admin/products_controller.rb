class Admin::ProductsController < Admin::BaseController

  # Internal: A testable class for use with strong_parameters.
  class ProductParams

    # Internal: Build params for creating/updating an Product.
    #
    # Examples
    #
    #   ProductParams.build(product: { name: 'Awesome Bedding' })
    #   # => { 'name' => 'Awesome Bedding' }
    def self.build(params)
      params.require(:product).permit!
    end
  end

  def index
    @products = Product.page(params[:page])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(ProductParams.build(params))
      redirect_to admin_products_path, notice: "Product successfully updated!"
    else
      flash[:error] = "There was a problem updating that product. Please make sure you filled out all of the fields"
      render :edit
    end
  end

  def new
    @product = Product.new
    @product.images.build
  end

  def create
    @product = Product.new(ProductParams.build(params))

    if @product.save
      expire_action controller: 'welcome', action: 'index'
      redirect_to admin_products_path, notice: "Product successfully created!"
    else
      flash[:error] = "There was a problem creating that product. Please make sure you filled out all of the fields"
      render :new
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      redirect_to admin_products_path, notice: "Product successfully deleted!"
    else
      flash[:error] = "There was a problem deleting that Product. Please try again."
      redirect_to admin_products_path
    end
  end
end
