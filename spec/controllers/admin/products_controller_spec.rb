require 'spec_helper'

describe Admin::ProductsController do

  def valid_params
    @valid_params ||= FactoryGirl.attributes_for(:product).stringify_keys
  end

  def do_update
    Product.stub(:find).and_return(@product)
    put :update, id: @product.id, product: valid_params
  end

  def do_create
    post :create, product: valid_params
  end

  def do_destroy
    delete :destroy, id: @product.id
  end

  before do
    @product = FactoryGirl.create(:product)
    sign_in_admin
  end

  describe 'GET index' do
    it 'should set @products' do
      get :index
      assigns(:products).should eq([@product])
    end
  end

  describe 'GET edit' do
    it 'should set @product' do
      get :edit, id: @product.id
      assigns(:product).should == @product
    end
  end

  describe 'PUT update' do
    it 'should set @product' do
      do_update
      assigns(:product).should == @product
    end

    it 'should update attributes' do
      Product.stub(:find).and_return(@product)
      @product.should_receive(:update_attributes)
      do_update
    end

    context 'when update succeeds' do
      it 'should redirect to the product' do
        do_update
        response.should redirect_to(admin_products_path)
      end

      it 'should set the flash appropriately' do
        do_update
        flash[:notice].should =~ /successfully updated/
      end
    end

    context 'when update fails' do
      before do
        Product.stub(:find).and_return(@product)
        @product.stub(:update_attributes).and_return(false)
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
    it 'should set @product to a new product' do
      get :new
      assigns(:product).should be_a_new(Product)
    end

    it 'should build a new image' do
      get :new
      assigns(:product).images.first.should be_a_new(Image)
    end
  end

  describe 'POST create' do
    it 'should set @product' do
      do_create
      assigns(:product).should be_a(Product)
    end

    it 'should build a new product and persist it' do
      Product.should_receive(:new).and_return(@product)
      @product.should_receive(:save)
      do_create
    end

    context 'when save succeeds' do
      before do
        Product.stub(:new).and_return(@product)
      end

      it 'should redirect to the product' do
        do_create
        response.should redirect_to(admin_products_path)
      end

      it 'should set the flash appropriately' do
        do_create
        flash[:notice].should =~ /successfully created/
      end
    end

    context 'when save fails' do
      before do
        Product.stub(:new).and_return(@product)
        @product.stub(:save).and_return(false)
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
      assigns(:product).should == @product
    end

    context 'when destroy succeeds' do
      it 'should redirect to products_path' do
        do_destroy
        response.should redirect_to(admin_products_path)
      end

      it 'should set the flash appropriately' do
        do_destroy
        flash[:notice].should =~ /successfully deleted/
      end
    end

    context 'when destroy fails' do
      before do
        Product.stub(:find).and_return(@product)
        @product.stub(:destroy).and_return(false)
      end

      it 'should set the flash appropriately' do
        do_destroy
        flash[:error].should =~ /problem deleting/
      end

      it 'should redirect to the product' do
        do_destroy
        response.should redirect_to(admin_products_path)
      end
    end
  end


end
