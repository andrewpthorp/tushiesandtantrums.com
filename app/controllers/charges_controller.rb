class ChargesController < ApplicationController

  # Internal: A testable class for use with strong_parameters.
  class ChargeParams

    # Internal: Build params for creating/updating an Charge.
    #
    # Examples
    #
    #   ChargeParams.build(charge: { name: 'Andrew' })
    #   # => { 'name' => 'Andrew' }
    def self.build(params)
      params.require(:charge).permit(:name, :email, :address_line_1,
                                     :address_line_2, :city, :state, :zip)
    end
  end

  def new
    @product = Product.find(params[:product_id])
    @charge = Charge.new(product_id: @product.id)

    if request.xhr?
      set_headers 'popup'
      render layout: 'popup'
    else
      render layout: 'minimal'
    end
  end

  def create
    @charge = Charge.new(charge_params)
    @product = @charge.product

    unless @charge.valid_without_stripe?
      flash.now[:error] = 'Oops! Make sure you filled out the whole form.'
      render :new, layout: 'minimal' and return
    end

    begin
      charge = Stripe::Charge.create(
        :amount => @product.price.fractional,
        :currency => "usd",
        :card => params[:stripeToken],
        :description => "#{@product.name} for #{@charge.email}"
      )

      @charge.stripe_charge_id = charge.id
      @charge.save

      redirect_to root_path, notice: 'Success! You will receive an email shortly.'
    rescue Stripe::CardError => e
      flash[:error] = "Oops! Your card was declined."
      redirect_to @product
    end
  end

private

  def charge_params
    params.require(:charge).permit!
  end

end
