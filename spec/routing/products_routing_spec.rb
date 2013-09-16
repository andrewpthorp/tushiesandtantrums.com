require 'spec_helper'

describe 'routes for Products' do

  describe '#index' do
    it 'should use /shop instead of /products' do
      route = '/shop'
      expect({ get: route }).to route_to('products#index')
    end

    describe 'default' do
      let(:route) { products_path }

      it 'should route correctly' do
        expect({ get: route }).to route_to('products#index')
      end
    end

    describe 'boys_products_path' do
      let (:route) { boys_products_path }

      it 'should route correctly' do
        expect({ get: route }).to route_to('products#index', category: 'boys')
      end
    end

    describe 'girls_products_path' do
      let (:route) { girls_products_path }

      it 'should route correctly' do
        expect({ get: route }).to route_to('products#index', category: 'girls')
      end
    end

    describe 'ready_ship_products_path' do
      let (:route) { ready_ship_products_path }

      it 'should route correctly' do
        expect({ get: route }).to route_to('products#index',
                                           category: 'ready-ship')
      end
    end
  end

  describe '#show' do
    let (:product) { FactoryGirl.create(:product) }
    let (:route) { product_path(product) }

    it 'should route correctly' do
      expect({ get: route }).to route_to('products#show', id: product.slug)
    end

    it 'should use /shop instead of /products' do
      route = "/shop/#{product.slug}"
      expect({ get: route }).to route_to('products#show', id: product.slug)
    end
  end

  describe 'unroutable' do
    let(:prefix) { '/shop' }

    it 'should not route' do
      expect({ get: '/products' }).not_to be_routable
      expect({ get: "#{prefix}/new" }).not_to route_to('products#new')
      expect({ get: "#{prefix}/5/edit" }).not_to be_routable
      expect({ put: "#{prefix}/5" }).not_to be_routable
      expect({ delete: "#{prefix}/5" }).not_to be_routable
    end
  end

end
