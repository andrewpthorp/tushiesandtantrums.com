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
      it 'should set all products for that category' do
        @product.update_attributes(tag_list: 'boys')
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
