class Admin::ChargesController < Admin::BaseController

  # GET /admin/charges
  def index
    @ordered = Charge.ordered.by_date
    @shipped = Charge.shipped.by_date
    @completed = Charge.completed.by_date
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

    if params[:return_to]
      redirect_to params[:return_to]
    else
      redirect_to admin_charge_path(@charge)
    end
  end

end
