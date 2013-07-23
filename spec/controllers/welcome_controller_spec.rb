require 'spec_helper'

describe WelcomeController do

  describe 'GET index' do
    it 'should respond with an HTTP 200' do
      get :index
      response.should be_success
    end
  end

  describe 'GET about' do
    it 'should respond with an HTTP 200' do
      get :index
      response.should be_success
    end
  end

end
