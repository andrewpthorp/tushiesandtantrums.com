require 'spec_helper'

describe 'admin routes for Products' do
  let(:product) { FactoryGirl.create(:product) }
  let(:route) { admin_products_path}

  describe '#index' do
    it 'should route correctly' do
      expect({ get: route }).to route_to('admin/products#index')
    end
  end

  describe '#new' do
    let (:route) { new_admin_product_path }

    it 'should route correctly' do
      expect({ get: route }).to route_to('admin/products#new')
    end
  end

  describe '#create' do
    it 'should route correctly' do
      expect({ post: route }).to route_to('admin/products#create')
    end
  end

  describe '#edit' do
    let(:route) { edit_admin_product_path(product) }

    it 'should route correctly' do
      expect({ get: route }).to route_to('admin/products#edit',
                                         id: product.slug)
    end
  end

  describe '#update' do
    let(:route) { admin_product_path(product) }

    it 'should route correctly' do
      expect({ put: route }).to route_to('admin/products#update',
                                         id: product.slug)
    end
  end

  describe '#destroy' do
    let(:route) { admin_product_path(product) }

    it 'should route correctly' do
      expect({ delete: route }).to route_to('admin/products#destroy',
                                           id: product.slug)
    end
  end

  describe 'unroutable' do
    it 'should not route' do
      expect({ get: '/admin/products/5' }).not_to be_routable
    end
  end
end

