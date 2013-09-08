class Admin::ProductsController < Admin::BaseController
  layout 'minimal'

  # GET /admin/products
  def index
    @products = Product.all
  end

  # GET /admin/products/:id/edit
  def edit
    @product = Product.find(params[:id])
  end

  # PUT /admin/products/:id
  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      redirect_to admin_products_path, notice: "Product successfully updated!"
    else
      flash[:error] = "There was a problem updating that product. Please make sure you filled out all of the fields"
      render :edit
    end
  end

  # GET /admin/products/new
  def new
    @product = Product.new
  end

  # POST /admin/products
  def create
    @product = Product.new(params[:product])

    if @product.save
      redirect_to admin_products_path, notice: "Product successfully created!"
    else
      flash[:error] = "There was a problem creating that product. Please make sure you filled out all of the fields"
      render :new
    end
  end

  # DELETE /admin/products/:id
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
