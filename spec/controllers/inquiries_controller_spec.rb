require 'spec_helper'

describe InquiriesController do

  # Internal: Reusable method to perform the HTTP POST.
  def do_create
    xhr :post, :create, inquiry: FactoryGirl.attributes_for(:inquiry)
  end

  describe InquiriesController::InquiryParams do
    let (:hash) { { inquiry: { name: 'Andrew', foo: 'bar' } } }
    let (:params) { ActionController::Parameters.new(hash) }
    let (:blank_params) { ActionController::Parameters.new({}) }

    it 'scrubs the parameters' do
      inquiry_params = InquiriesController::InquiryParams.build(params)
      expect(inquiry_params).to eq({'name' => 'Andrew'})
    end

    it 'requires an inquiry' do
      expect { InquiriesController::InquiryParams.build(blank_params) }.to(
        raise_error(ActionController::ParameterMissing, /inquiry/)
      )
    end
  end

  describe 'GET new' do
    it 'should assign @inquiry' do
      get :new
      expect(assigns(:inquiry)).to be_a(Inquiry)
    end

    context 'when the request is xhr?' do
      it 'should set the ajax header' do
        xhr :get, :new
        expect(response.headers['Ajax-Type']).to eq('popup')
      end

      it 'should use the popup layout' do
        xhr :get, :new
        expect(response).to render_template(layout: 'layouts/popup')
      end
    end

    context 'when the request is not xhr?' do
      it 'should use the minimal layout' do
        get :new
        expect(response).to render_template(layout: 'layouts/minimal')
      end
    end
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
