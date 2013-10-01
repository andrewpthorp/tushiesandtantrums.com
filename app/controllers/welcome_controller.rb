class WelcomeController < ApplicationController

  caches_action :index, layout: false

  def index
    @active_navigation = 'home'
    @products = Product.newest.limit(4)
  end

end
