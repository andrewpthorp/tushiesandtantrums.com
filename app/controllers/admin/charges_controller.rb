class Admin::ChargesController < Admin::BaseController

  def index
    @ordered = Charge.ordered.by_date.page(params[:ordered_page])
    @shipped = Charge.shipped.by_date.page(params[:shipped_page])
    @completed = Charge.completed.by_date.page(params[:completed_page])
  end

  def show
    @charge = Charge.find(params[:id])
  end

  def update
    @charge = Charge.find(params[:id])

    if @charge.update_attributes(params[:charge])
      flash[:notice] = 'Order successfully updated!'
    else
      flash[:error] = 'Oops! There was a problem updating that order.'
    end

    redirect_to params[:return_to] || admin_charge_path(@charge)
  end

end
