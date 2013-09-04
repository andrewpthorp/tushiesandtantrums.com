require 'spec_helper'

def valid_params(opts={})
  {
    'name' => opts[:name] || "Product Name",
    'description' => opts[:description] || "Product Description",
    'price' => opts[:price] || "$285.50",
    'image' => opts[:image] || "foobar"
  }
end

def do_update
  put :update, id: 1, product: valid_params
end

def do_create
  post :create, product: valid_params
end

def do_destroy
  delete :destroy, id: 1
end

describe ProductsController do
  before do
    @mock_product = mock_model(Product)
    @mock_product.stub(:update_attributes).and_return(true)
    @mock_product.stub(:save).and_return(true)
    @mock_product.stub(:destroy).and_return(true)

    Product.stub(:find).and_return(@mock_product)
    Product.stub(:all).and_return([@mock_product])
    Product.stub(:new).and_return(@mock_product)
  end

  describe 'GET index' do
    it 'should set @active_navigation' do
      get :index
      assigns(:active_navigation).should == 'products'
    end

    it 'should set @products' do
      get :index
      assigns(:products).should == [@mock_product]
    end
  end

  describe 'GET show' do
    it 'should set @active_navigation' do
      get :show, id: 1
      assigns(:active_navigation).should == 'products'
    end

    it 'should set @product' do
      get :show, id: 1
      assigns(:product).should == @mock_product
    end
  end

  describe 'GET edit' do
    it 'should set @active_navigation' do
      get :edit, id: 1
      assigns(:active_navigation).should == 'products'
    end

    it 'should set @product' do
      get :edit, id: 1
      assigns(:product).should == @mock_product
    end
  end

  describe 'PUT update' do
    it 'should set @active_navigation' do
      do_update
      assigns(:active_navigation).should == 'products'
    end

    it 'should set @product' do
      do_update
      assigns(:product).should == @mock_product
    end

    it 'should update attributes' do
      @mock_product.should_receive(:update_attributes).with(valid_params)
      do_update
    end

    context 'when update succeeds' do
      it 'should redirect to the product' do
        do_update
        response.should redirect_to(@mock_product)
      end

      it 'should set the flash appropriately' do
        do_update
        flash[:notice].should =~ /successfully updated/
      end
    end

    context 'when update fails' do
      before do
        @mock_product.stub(:update_attributes).and_return(false)
      end

      it 'should set the flash appropriately' do
        do_update
        flash[:error].should =~ /problem updating/
      end

      it 'should render the edit template' do
        do_update
        response.should render_template(:edit)
      end
    end
  end

  describe 'GET new' do
    it 'should set @active_navigation' do
      get :new
      assigns(:active_navigation).should == 'products'
    end

    it 'should set @product' do
      get :new
      assigns(:product).should == @mock_product
    end

    it 'should not persist @product' do
      Product.should_receive(:new).and_return(@mock_product)
      @mock_product.should_not_receive(:save)
      get :new
    end
  end

  describe 'POST create' do
    it 'should set @active_navigation' do
      do_create
      assigns(:active_navigation).should == 'products'
    end

    it 'should set @product' do
      do_create
      assigns(:product).should == @mock_product
    end

    it 'should build a new product' do
      Product.should_receive(:new).and_return(@mock_product)
      @mock_product.should_receive(:save)
      do_create
    end

    context 'when save succeeds' do
      it 'should redirect to the product' do
        do_create
        response.should redirect_to(@mock_product)
      end

      it 'should set the flash appropriately' do
        do_create
        flash[:notice].should =~ /successfully created/
      end
    end

    context 'when save fails' do
      before do
        @mock_product.stub(:save).and_return(false)
      end

      it 'should set the flash appropriately' do
        do_create
        flash[:error].should =~ /problem creating/
      end

      it 'should render the new template' do
        do_create
        response.should render_template(:new)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'should set @product' do
      do_destroy
      assigns(:product).should == @mock_product
    end

    context 'when destroy succeeds' do
      it 'should redirect to products_path' do
        do_destroy
        response.should redirect_to(products_path)
      end

      it 'should set the flash appropriately' do
        do_destroy
        flash[:notice].should =~ /successfully deleted/
      end
    end

    context 'when destroy fails' do
      before do
        @mock_product.stub(:destroy).and_return(false)
      end

      it 'should set the flash appropriately' do
        do_destroy
        flash[:error].should =~ /problem deleting/
      end

      it 'should redirect to the product' do
        do_destroy
        response.should redirect_to(@mock_product)
      end
    end
  end

end
