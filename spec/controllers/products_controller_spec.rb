require 'spec_helper'

def valid_params
  @valid_params ||= FactoryGirl.attributes_for(:product).stringify_keys
end

def do_update
  put :update, id: @product.id, product: valid_params
end

def do_create
  post :create, product: valid_params
end

def do_destroy
  delete :destroy, id: @product.id
end

describe ProductsController do
  before do
    @product = FactoryGirl.create(:product)
  end

  describe 'GET index' do
    it 'should set @active_navigation' do
      get :index
      assigns(:active_navigation).should == 'products'
    end

    it 'should set @products' do
      get :index
      assigns(:products).should == [@product]
    end

    context 'when passing a category' do
      it 'should get products for that category' do
        Product.should_receive(:tagged_with).with('boys')
        get :index, category: 'boys'
      end

      it 'should set all products for that category' do
        Product.stub(:tagged_with).and_return([@product])
        get :index, category: 'boys'
        assigns(:products).should == [@product]
      end

      it 'should set @category' do
        get :index, category: 'boys'
        assigns(:category).should == 'boys'
      end
    end
  end

  describe 'GET show' do
    it 'should set @active_navigation' do
      get :show, id: @product.id
      assigns(:active_navigation).should == 'products'
    end

    it 'should set @product' do
      get :show, id: @product.id
      assigns(:product).should == @product
    end
  end

  describe 'GET edit' do
    it 'should set @active_navigation' do
      get :edit, id: @product.id
      assigns(:active_navigation).should == 'products'
    end

    it 'should set @product' do
      get :edit, id: @product.id
      assigns(:product).should == @product
    end
  end

  describe 'PUT update' do
    it 'should set @active_navigation' do
      do_update
      assigns(:active_navigation).should == 'products'
    end

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
        response.should redirect_to(@product)
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
    it 'should set @active_navigation' do
      get :new
      assigns(:active_navigation).should == 'products'
    end

    it 'should set @product' do
      get :new
      assigns(:product).should be_a(Product)
    end

    it 'should not persist @product' do
      @product.should_not_receive(:save)
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
        response.should redirect_to(@product)
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
        response.should redirect_to(products_path)
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
        response.should redirect_to(@product)
      end
    end
  end

end
