require 'spec_helper'

describe PostsController do

  before do
    @latest = FactoryGirl.create(:post)
    @old = FactoryGirl.create(:post, created_at: 5.days.ago)
    @draft = FactoryGirl.create(:draft)
  end

  describe 'GET index' do
    it 'should set @active_navigation' do
      get :index
      expect(assigns(:active_navigation)).to eq('posts')
    end

    it 'should set @latest' do
      get :index
      expect(assigns(:latest)).to eq(@latest)
    end

    it 'should set @posts to ordered, published, and not include the latest' do
      newer = FactoryGirl.create(:post, created_at: 2.days.ago)
      get :index
      expect(assigns(:posts)).to eq([newer, @old])
    end

    it 'should render the minimal layout' do
      get :index
      expect(response).to render_template(layout: 'layouts/minimal')
    end
  end

  describe 'GET show' do
    it 'should set @active_navigation' do
      get :show, id: @latest
      expect(assigns(:active_navigation)).to eq('posts')
    end

    it 'should set @post' do
      get :show, id: @latest
      expect(assigns(:post)).to eq(@latest)
    end

    it 'should render the minimal layout' do
      get :show, id: @latest
      expect(response).to render_template(layout: 'layouts/minimal')
    end
  end

end
