class WelcomeController < ApplicationController

  def index
    @active_navigation = 'home'
    @products = Product.newest.limit(4)
  end

end
