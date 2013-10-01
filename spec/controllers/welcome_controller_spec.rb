require 'spec_helper'

describe WelcomeController do

  describe 'GET index' do
    it 'should set @active_navigation' do
      get :index
      expect(assigns(:active_navigation)).to eq('home')
    end

    it 'should get the four newest products products' do
      5.times { FactoryGirl.create(:product) }
      get :index
      expect(assigns(:products)).not_to include(Product.first)
    end

    it 'should respond with an HTTP 200' do
      get :index
      expect(response).to be_success
    end
  end

end
