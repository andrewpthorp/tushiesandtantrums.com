require 'spec_helper'

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

end
