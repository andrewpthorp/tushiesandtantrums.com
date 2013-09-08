require 'spec_helper'

describe 'charge routes' do

  describe 'new_product_charges_path' do
    it 'should route correctly' do
      product = FactoryGirl.create(:product)
      expect({ get: new_product_charges_path(product) }).to(
        route_to(controller: 'charges', action: 'new', product_id: product.slug)
      )
    end
  end

end
