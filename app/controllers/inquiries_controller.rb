class InquiriesController < ApplicationController

  def create
    @inquiry = Inquiry.new(params[:inquiry])

    if @inquiry.save
      flash_headers 'Successfully sent message!'
    else
      flash_headers 'There was a problem sending your message. All fields are required.', 'error'
    end

    render nothing: true
  end

protected

  # Internal: Set the headers used for AJAX requests.
  #
  # message - String for the 'Flash-Message' header.
  # type    - String for the 'Flash-Message-Type' header (default: 'success').
  #
  # Returns nothing.
  def flash_headers(message, type='success')
    response.headers['Flash-Message'] = message
    response.headers['Flash-Message-Type'] = type
  end

end
