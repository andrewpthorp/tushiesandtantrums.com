class Admin::InquiriesController < Admin::BaseController

  def index
    @inquiries = Inquiry.order('created_at DESC').page(params[:page])
  end

  def show
    @inquiry = Inquiry.find(params[:id])
    @inquiry.update_attributes(status: 'read') if @inquiry.unread?
  end

  def destroy
    @inquiry = Inquiry.find(params[:id])

    if @inquiry.destroy
      flash[:notice] = 'Message successfully deleted!'
      redirect_to admin_inquiries_path
    else
      flash[:error] = 'Oops! There was a problem deleting that message.'
      redirect_to admin_inquiry_path(@inquiry)
    end
  end

end
