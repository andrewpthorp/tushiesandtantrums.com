class WelcomeController < ApplicationController

  # Internal: Cache GET /index in memcached.
  caches_action :index, layout: false

  def index
    @active_navigation = 'home'
    @products = Product.newest.limit(4)
  end

end
