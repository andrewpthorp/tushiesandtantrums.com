class WelcomeController < ApplicationController

  def index
    @active_navigation = 'home'
    @products = Product.random.limit(4)
  end

end
