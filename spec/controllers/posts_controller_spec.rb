require 'spec_helper'

describe PostsController do

  before do
    @post = FactoryGirl.create(:post)
  end

  describe 'GET index' do
    it 'should set @active_navigation' do
      get :index
      assigns(:active_navigation).should == 'posts'
    end

    it 'should set @posts' do
      get :index
      assigns(:posts).should == [@post]
    end
  end

  describe 'GET show' do
    it 'should set @active_navigation' do
      get :show, id: @post.id
      assigns(:active_navigation).should == 'posts'
    end

    it 'should set @post' do
      get :show, id: @post.id
      assigns(:post).should == @post
    end
  end

end
