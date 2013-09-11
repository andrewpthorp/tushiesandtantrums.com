require 'spec_helper'

describe 'routes for Posts' do

  describe '#index' do
    it 'should use /blog instead of /posts' do
      route = '/blog'
      expect({ get: route }).to route_to('posts#index')
    end
  end

  describe '#show' do
    let (:post) { FactoryGirl.create(:post) }
    let (:route) { post_path(post) }

    it 'should route correctly' do
      expect({ get: route }).to route_to('posts#show', id: post.slug)
    end

    it 'should use /blog instead of /posts' do
      route = "/blog/#{post.slug}"
      expect({ get: route }).to route_to('posts#show', id: post.slug)
    end
  end

  describe 'unroutable' do
    let(:prefix) { '/blog' }

    it 'should not route' do
      expect({ get: '/posts' }).not_to be_routable
      expect({ get: "#{prefix}/new" }).not_to route_to('posts#new')
      expect({ get: "#{prefix}/5/edit" }).not_to be_routable
      expect({ put: "#{prefix}/5" }).not_to be_routable
      expect({ delete: "#{prefix}/5" }).not_to be_routable
    end
  end

end
