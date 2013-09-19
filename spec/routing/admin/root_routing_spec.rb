require 'spec_helper'

describe 'admin routes for root' do
  let(:route) { admin_root_path }

  it 'should route correctly' do
    expect({ get: route }).to route_to('admin/products#index')
  end
end
