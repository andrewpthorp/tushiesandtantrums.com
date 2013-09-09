require 'spec_helper'

describe Admin::ChargesController do
  before do
    @charge = FactoryGirl.create(:charge)
    sign_in_admin
  end

  describe 'GET index' do
    it 'should set @ordered' do
      get :index
      expect(assigns(:ordered)).to eq([@charge])
    end

    it 'should set @shipped' do
      @charge.update_attributes(status: 'shipped')
      get :index
      expect(assigns(:shipped)).to eq([@charge])
    end

    it 'should set @completed' do
      @charge.update_attributes(status: 'completed')
      get :index
      expect(assigns(:completed)).to eq([@charge])
    end

    it 'should render the admin layout' do
      get :index
      expect(response).to render_template(layout: 'layouts/admin')
    end
  end

  describe 'GET show' do
    it 'should set @charge' do
      get :show, id: @charge.id
      expect(assigns(:charge)).to eq(@charge)
    end

    it 'should render the admin layout' do
      get :show, id: @charge.id
      expect(response).to render_template(layout: 'layouts/admin')
    end
  end

  describe 'PUT update' do
    before do
      Charge.stub(:find).and_return(@charge)
    end

    it 'should redirect to admin_charge_path' do
      put :update, id: @charge.id, charge: { status: 'shipped' }
      expect(response).to redirect_to(admin_charge_path(@charge))
    end

    context 'when passing a return_to param' do
      it 'should redirect to the return_to' do
        put :update, id: @charge.id, charge: {}, return_to: '/foo'
        expect(response).to redirect_to('/foo')
      end
    end

    context 'when the charge is successfully updated' do
      it 'should set the flash correctly' do
        @charge.stub(:update_attributes).and_return(true)
        put :update, id: @charge.id, charge: { status: 'shipped' }
        expect(flash[:notice]).to match(/success/)
      end
    end

    context 'when the charge cannot be updated' do
      it 'should set the flash correctly' do
        @charge.stub(:update_attributes).and_return(false)
        put :update, id: @charge.id, charge: { status: 'shipped' }
        expect(flash[:error]).to match(/problem updating/)
      end
    end
  end
end
