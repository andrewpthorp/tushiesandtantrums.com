require 'spec_helper'

describe InquiriesController do

  def do_create
    xhr :post, :create, inquiry: FactoryGirl.attributes_for(:inquiry)
  end

  describe 'POST create' do
    it 'should assign @inquiry' do
      do_create
      expect(assigns(:inquiry)).to be_a(Inquiry)
    end

    context 'when an inquiry saves' do
      before do
        Inquiry.any_instance.stub(:save).and_return(true)
      end

      it 'should set the ajax header' do
        do_create
        expect(response.headers['Ajax-Type']).to eq('flash')
      end

      it 'should set the flash message header' do
        do_create
        expect(response.headers['Flash-Message']).to match(/Success/)
      end

      it 'should set the flash message type header' do
        do_create
        expect(response.headers['Flash-Message-Type']).to eq('success')
      end
    end

    context 'when an inquiry fails to save' do
      before do
        Inquiry.any_instance.stub(:save).and_return(false)
      end

      it 'should set the ajax header' do
        do_create
        expect(response.headers['Ajax-Type']).to eq('flash')
      end

      it 'should set the flash message header' do
        do_create
        expect(response.headers['Flash-Message']).to match(/problem sending/)
      end

      it 'should set the flash message type header' do
        do_create
        expect(response.headers['Flash-Message-Type']).to eq('error')
      end
    end

    it 'should be successful' do
      do_create
      expect(response).to be_success
    end
  end

end
