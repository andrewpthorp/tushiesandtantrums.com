class Admin::ChargesController < Admin::BaseController
  layout 'minimal'

  # GET /admin/charges
  def index
    @ordered = Charge.ordered
    @shipped = Charge.shipped
    @completed = Charge.completed
  end

  # GET /admin/charges/:id
  def show
    @charge = Charge.find(params[:id])
  end

  # PUT /admin/charges/:id
  def update
    @charge = Charge.find(params[:id])

    if @charge.update_attributes(params[:charge])
      flash[:notice] = 'Order successfully updated!'
    else
      flash[:error] = 'Oops! There was a problem updating that order.'
    end

    redirect_to admin_charge_path(@charge)
  end

end
