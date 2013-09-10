require 'spec_helper'

describe 'admin routes for Inquiries' do
  let(:inquiry) { FactoryGirl.create(:inquiry) }
  let(:route) { admin_inquiries_path }

  describe '#index' do
    it 'should route correctly' do
      expect({ get: route }).to route_to('admin/inquiries#index')
    end
  end

  describe '#show' do
    let (:route) { admin_inquiry_path(inquiry) }

    it 'should route correctly' do
      expect({ get: route }).to route_to('admin/inquiries#show',
                                         id: inquiry.id.to_s)
    end
  end

  describe '#destroy' do
    let(:route) { admin_inquiry_path(inquiry) }

    it 'should route correctly' do
      expect({ delete: route }).to route_to('admin/inquiries#destroy',
                                         id: inquiry.id.to_s)
    end
  end

  describe 'unroutable' do
    let (:prefix) { '/admin/inquiries' }

    it 'should not route' do
      expect({ get: "#{prefix}/new" }).not_to route_to('admin/inquiries#new')
      expect({ get: "#{prefix}/5/edit" }).not_to be_routable
      expect({ post: "#{prefix}" }).not_to be_routable
      expect({ put: "#{prefix}/5" }).not_to be_routable
    end
  end
end
