require 'spec_helper'

describe WelcomeController do

  describe 'GET index' do
    it 'should set @active_navigation' do
      get :index
      expect(assigns(:active_navigation)).to eq('home')
    end

    it 'should get the four newest products products' do
      mock_products = double('array')
      Product.stub_chain(:newest, :limit).and_return(mock_products)
      get :index
      expect(assigns(:products)).to eq(mock_products)
    end

    it 'should respond with an HTTP 200' do
      get :index
      expect(response).to be_success
    end
  end

end
