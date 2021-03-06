require 'spec_helper'

describe 'routes for Charges' do

  describe '#new' do
    describe 'new_product_charges_path' do
      let(:product) { FactoryGirl.create(:product) }
      let(:route) { new_product_charges_path(product) }

      it 'should route correctly' do
        expect({ get: route }).to route_to('charges#new',
                                           product_id: product.slug)
      end
    end
  end

  describe '#create' do
    let (:route) { charges_path }

    it 'should route correctly' do
      expect({ post: route }).to route_to('charges#create')
    end
  end

  describe 'unroutable' do
    let (:prefix) { '/charges' }

    it 'should not route' do
      expect({ get: "#{prefix}" }).not_to be_routable
      expect({ get: "#{prefix}/5" }).not_to be_routable
      expect({ get: "#{prefix}/new" }).not_to be_routable
      expect({ get: "#{prefix}/5/edit" }).not_to be_routable
      expect({ put: "#{prefix}/5" }).not_to be_routable
      expect({ delete: "#{prefix}/5" }).not_to be_routable
    end
  end

end
