require 'spec_helper'

describe 'routes for Inquiries' do

  describe '#new' do
    describe 'new_inquiry_path' do
      let(:route) { new_inquiry_path }

      it 'should route correctly' do
        expect({ get: route }).to route_to('inquiries#new')
      end
    end
  end

  describe '#create' do
    let (:route) { inquiries_path }

    it 'should route correctly' do
      expect({ post: route }).to route_to('inquiries#create')
    end
  end

  describe 'unroutable' do
    let (:prefix) { '/inquiries' }

    it 'should not route' do
      expect({ get: "#{prefix}" }).not_to be_routable
      expect({ get: "#{prefix}/5" }).not_to be_routable
      expect({ get: "#{prefix}/5/edit" }).not_to be_routable
      expect({ put: "#{prefix}/5" }).not_to be_routable
      expect({ delete: "#{prefix}/5" }).not_to be_routable
    end
  end

end
