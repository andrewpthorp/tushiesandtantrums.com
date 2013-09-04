require 'spec_helper'

describe WelcomeController do

  describe 'GET index' do
    it 'should set @active_navigation' do
      get :index
      assigns(:active_navigation).should == 'home'
    end

    it 'should respond with an HTTP 200' do
      get :index
      response.should be_success
    end
  end

end
