class InquiriesController < ApplicationController

  # Internal: A testable class for use with strong_parameters.
  class InquiryParams

    # Internal: Build params for creating/updating an Inquiry.
    #
    # Examples
    #
    #   InquiryParams.build(inquiry: { name: 'Andrew' })
    #   # => { 'name' => 'Andrew' }
    def self.build(params)
      params.require(:inquiry).permit(:name, :email, :subject, :body)
    end
  end

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
    @inquiry = Inquiry.new(InquiryParams.build(params))

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
