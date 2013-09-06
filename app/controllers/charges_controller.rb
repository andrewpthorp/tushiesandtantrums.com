class ChargesController < ApplicationController
  layout 'charges'

  def new
    @product = Product.find(params[:product_id])
    @charge = Charge.new(product_id: @product.id)
  end

  def create
    @charge = Charge.new(params[:charge])
    @product = @charge.product

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

end
