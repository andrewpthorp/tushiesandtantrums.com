require 'spec_helper'

describe 'routes for root' do
  let(:route) { root_path }

  it 'should route correctly' do
    expect({ get: route }).to route_to('welcome#index')
  end
end
