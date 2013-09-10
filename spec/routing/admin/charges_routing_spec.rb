require 'spec_helper'

describe 'admin routes for Charges' do
  let(:charge) { FactoryGirl.create(:charge) }
  let(:route) { admin_charges_path }

  describe '#index' do
    it 'should route correctly' do
      expect({ get: route }).to route_to('admin/charges#index')
    end
  end

  describe '#show' do
    let (:route) { admin_charge_path(charge) }

    it 'should route correctly' do
      expect({ get: route }).to route_to('admin/charges#show',
                                         id: charge.id.to_s)
    end
  end

  describe '#update' do
    let(:route) { admin_charge_path(charge) }

    it 'should route correctly' do
      expect({ put: route }).to route_to('admin/charges#update',
                                         id: charge.id.to_s)
    end
  end

  describe 'unroutable' do
    let (:prefix) { '/admin/charges' }

    it 'should not route' do
      expect({ get: "#{prefix}/new" }).not_to route_to('admin/charges#new')
      expect({ get: "#{prefix}/5/edit" }).not_to be_routable
      expect({ post: "#{prefix}" }).not_to be_routable
      expect({ delete: "#{prefix}/5" }).not_to be_routable
    end
  end
end
