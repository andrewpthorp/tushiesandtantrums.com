require 'spec_helper'

describe 'admin routes for Posts' do
  let(:post) { FactoryGirl.create(:post) }
  let(:route) { admin_posts_path}

  describe '#index' do
    it 'should route correctly' do
      expect({ get: route }).to route_to('admin/posts#index')
    end
  end

  describe '#new' do
    let (:route) { new_admin_post_path }

    it 'should route correctly' do
      expect({ get: route }).to route_to('admin/posts#new')
    end
  end

  describe '#create' do
    it 'should route correctly' do
      expect({ post: route }).to route_to('admin/posts#create')
    end
  end

  describe '#edit' do
    let(:route) { edit_admin_post_path(post) }

    it 'should route correctly' do
      expect({ get: route }).to route_to('admin/posts#edit',
                                         id: post.slug)
    end
  end

  describe '#update' do
    let(:route) { admin_post_path(post) }

    it 'should route correctly' do
      expect({ put: route }).to route_to('admin/posts#update',
                                         id: post.slug)
    end
  end

  describe '#destroy' do
    let(:route) { admin_post_path(post) }

    it 'should route correctly' do
      expect({ delete: route }).to route_to('admin/posts#destroy',
                                           id: post.slug)
    end
  end

  describe 'unroutable' do
    it 'should not route' do
      expect({ get: '/admin/posts/5' }).not_to be_routable
    end
  end
end

