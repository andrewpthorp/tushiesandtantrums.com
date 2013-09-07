require 'spec_helper'

describe ChargesController do

  def do_get(use_xhr=false)
    @product = FactoryGirl.create(:product)
    if use_xhr
      xhr :get, :new, product_id: @product.id
    else
      get :new, product_id: @product.id
    end
  end

  def do_create(valid_without_stripe=true)
    @charge = FactoryGirl.build(:charge)
    @product = @charge.product
    Charge.stub(:new).and_return(@charge)
    @charge.stub(:valid_without_stripe?).and_return(valid_without_stripe)
    post :create, charge: FactoryGirl.attributes_for(:charge)
  end

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

    context 'when the request is xhr?' do
      it 'should use the popup layout' do
        do_get(true)
        expect(response).to render_template(layout: 'layouts/popup')
      end
    end

    context 'when the request is not xhr?' do
      it 'should use the minimal layout' do
        do_get
        expect(response).to render_template(layout: 'layouts/minimal')
      end
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

    context 'with invalid data that does not include Stripe' do
      it 'should render the charge form' do
        do_create(false)
        response.should render_template(:new)
      end

      it 'should set the flash' do
        do_create(false)
        flash.now[:error].should eq('Oops! Make sure you filled out the whole form.')
      end
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
