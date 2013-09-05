require 'spec_helper'

def do_create
  xhr :post, :create, inquiry: FactoryGirl.attributes_for(:inquiry)
end

describe InquiriesController do

  describe 'POST create' do
    it 'should assign @inquiry' do
      do_create
      assigns(:inquiry).should be_a(Inquiry)
    end

    context 'when an inquiry saves' do
      it 'should set the flash message header' do
        do_create
        response.headers['Flash-Message'].should match(/Success/)
      end

      it 'should set the flash message type header' do
        do_create
        response.headers['Flash-Message-Type'].should eq('success')
      end
    end

    context 'when an inquiry fails to save' do
      before do
        @inquiry = FactoryGirl.build(:inquiry)
        Inquiry.stub(:new).and_return(@inquiry)
        @inquiry.stub(:save).and_return(false)
      end

      it 'should set the flash message header' do
        do_create
        response.headers['Flash-Message'].should match(/problem sending/)
      end

      it 'should set the flash message type header' do
        do_create
        response.headers['Flash-Message-Type'].should eq('error')
      end
    end

    it 'should be successful' do
      do_create
      response.should be_success
    end
  end

end
