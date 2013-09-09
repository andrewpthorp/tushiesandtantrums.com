class InquiriesController < ApplicationController

  def new
    @inquiry = Inquiry.new

    if request.xhr?
      set_headers 'popup'
      render layout: 'popup'
    else
      render layout: 'minimal'
    end
  end

  def create
    @inquiry = Inquiry.new(params[:inquiry])

    if @inquiry.save
      set_headers 'flash', { 'Flash-Message' => 'Successfully sent message!',
                             'Flash-Message-Type' => 'success' }
    else
      set_headers 'flash', { 'Flash-Message' => 'There was a problem sending your message. All fields are required.',
                             'Flash-Message-Type' => 'error' }
    end

    render nothing: true
  end

end
