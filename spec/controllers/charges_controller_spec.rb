require 'spec_helper'

def do_get
  @product = FactoryGirl.create(:product)
  get :new, product_id: @product.id
end

def do_create
  @charge = FactoryGirl.build(:charge)
  @product = @charge.product
  Charge.stub(:new).and_return(@charge)
  post :create, charge: FactoryGirl.attributes_for(:charge)
end

describe ChargesController do

  describe 'GET new' do
    it 'should assign @product' do
      do_get
      expect(assigns(:product)).to eq(@product)
    end

    it 'should assign @charge' do
      do_get
      expect(assigns(:charge)).to be_a(Charge)
    end

    it 'should set the product on @charge' do
      do_get
      expect(assigns(:charge).product).to eq(@product)
    end
  end

  describe 'POST create' do
    it 'should assign @charge' do
      do_create
      expect(assigns(:charge)).to be_a(Charge)
    end

    it 'should assign @product' do
      do_create
      expect(assigns(:product)).to be_a(Product)
    end

    it 'should create a Stripe::Charge' do
      charge = Stripe::Charge.create
      expect(Stripe::Charge).to receive(:create).and_return(charge)
      do_create
    end

    it 'should set the stripe_charge_id on @charge' do
      do_create
      expect(assigns(:charge).stripe_charge_id).not_to be_nil
    end

    it 'should redirect to the root path' do
      do_create
      expect(response).to redirect_to(root_path)
    end

    it 'should set the flash' do
      do_create
      expect(flash[:notice]).to match(/Success/)
    end

    context 'when the credit card is declined' do
      before do
        StripeMock.prepare_card_error(:incorrect_number)
      end

      it 'should redirect to the product' do
        do_create
        expect(response).to redirect_to(@product)
      end

      it 'should set the flash' do
        do_create
        expect(flash[:error]).to eq('Oops! Your card was declined.')
      end
    end
  end

end
