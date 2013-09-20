require 'spec_helper'

describe Admin::InquiriesController do

  def do_delete
    delete :destroy, id: @inquiry.id
  end

  before do
    @inquiry = FactoryGirl.create(:inquiry)
    sign_in_admin
  end

  describe 'GET index' do
    it 'should set @inquiries' do
      get :index
      expect(assigns(:inquiries)).to eq([@inquiry])
    end
  end

  describe 'GET show' do
    before do
      Inquiry.stub(:find).and_return(@inquiry)
    end

    it 'should set @inquiry' do
      get :show, id: @inquiry.id
      expect(assigns(:inquiry)).to eq(@inquiry)
    end

    context 'when the inquiry is unread' do
      it 'should mark the inquiry as read' do
        @inquiry.should_receive(:update_attributes).with({status: 'read'})
        get :show, id: @inquiry.id
      end
    end

    context 'when the inquiry is read' do
      it 'should not change the inquiry status' do
        @inquiry.update_attributes(status: 'read')
        @inquiry.should_not_receive(:update_attributes)
        get :show, id: @inquiry.id
      end
    end
  end

  describe 'DELETE destroy' do
    context 'when deleting is successful' do
      it 'should set the flash' do
        do_delete
        expect(flash[:notice]).to match(/success/)
      end

      it 'should redirect to all inquiries' do
        do_delete
        expect(response).to redirect_to(admin_inquiries_path)
      end
    end

    context 'when deleting fails' do
      before do
        Inquiry.stub(:find).and_return(@inquiry)
        @inquiry.stub(:destroy).and_return(false)
      end

      it 'should set the flash' do
        do_delete
        expect(flash[:error]).to match(/problem deleting/)
      end

      it 'should redirect to the inquiry' do
        do_delete
        expect(response).to redirect_to(admin_inquiry_path(@inquiry))
      end
    end
  end

end
