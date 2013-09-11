require 'spec_helper'

describe Admin::PostsController do

  def valid_params
    @valid_params ||= FactoryGirl.attributes_for(:post).stringify_keys
  end

  def do_update
    Post.stub(:find).and_return(@post)
    put :update, id: @post.id, post: valid_params
  end

  def do_create
    post :create, post: valid_params
  end

  def do_destroy
    delete :destroy, id: @post.id
  end

  before do
    @post = FactoryGirl.create(:post)
    @draft = FactoryGirl.create(:draft)
    sign_in_admin
  end

  describe 'GET index' do
    it 'should set @drafted' do
      get :index
      assigns(:published).should eq([@post])
    end

    it 'should set @published' do
      get :index
      assigns(:drafted).should eq([@draft])
    end
  end

  describe 'GET edit' do
    it 'should set @post' do
      get :edit, id: @post.id
      assigns(:post).should == @post
    end
  end

  describe 'PUT update' do
    it 'should set @post' do
      do_update
      assigns(:post).should == @post
    end

    it 'should update attributes' do
      Post.stub(:find).and_return(@post)
      @post.should_receive(:update_attributes)
      do_update
    end

    context 'when update succeeds' do
      it 'should redirect to the post' do
        do_update
        response.should redirect_to(admin_posts_path)
      end

      it 'should set the flash appropriately' do
        do_update
        flash[:notice].should =~ /successfully updated/
      end
    end

    context 'when update fails' do
      before do
        Post.stub(:find).and_return(@post)
        @post.stub(:update_attributes).and_return(false)
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
    it 'should set @post' do
      get :new
      assigns(:post).should be_a(Post)
    end

    it 'should not persist @post' do
      @post.should_not_receive(:save)
      get :new
    end
  end

  describe 'POST create' do
    it 'should set @post' do
      do_create
      assigns(:post).should be_a(Post)
    end

    it 'should build a new post and persist it' do
      Post.should_receive(:new).and_return(@post)
      @post.should_receive(:save)
      do_create
    end

    context 'when save succeeds' do
      before do
        Post.stub(:new).and_return(@post)
      end

      it 'should redirect to the post' do
        do_create
        response.should redirect_to(admin_posts_path)
      end

      it 'should set the flash appropriately' do
        do_create
        flash[:notice].should =~ /successfully created/
      end
    end

    context 'when save fails' do
      before do
        Post.stub(:new).and_return(@post)
        @post.stub(:save).and_return(false)
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
    it 'should set @post' do
      do_destroy
      assigns(:post).should == @post
    end

    context 'when destroy succeeds' do
      it 'should redirect to posts_path' do
        do_destroy
        response.should redirect_to(admin_posts_path)
      end

      it 'should set the flash appropriately' do
        do_destroy
        flash[:notice].should =~ /successfully deleted/
      end
    end

    context 'when destroy fails' do
      before do
        Post.stub(:find).and_return(@post)
        @post.stub(:destroy).and_return(false)
      end

      it 'should set the flash appropriately' do
        do_destroy
        flash[:error].should =~ /problem deleting/
      end

      it 'should redirect to the post' do
        do_destroy
        response.should redirect_to(admin_posts_path)
      end
    end
  end


end
