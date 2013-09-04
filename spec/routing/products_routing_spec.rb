require 'spec_helper'

describe 'product routes' do

  describe 'boys_products_path' do
    it 'should route correctly' do
      expect({ get: boys_products_path }).to(
        route_to(controller: 'products', action: 'index', category: 'boys')
      )
    end
  end

  describe 'girls_products_path' do
    it 'should route correctly' do
      expect({ get: girls_products_path }).to(
        route_to(controller: 'products', action: 'index', category: 'girls')
      )
    end
  end

end
