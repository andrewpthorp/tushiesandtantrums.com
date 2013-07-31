class WelcomeController < ApplicationController

  def index
    @active_navigation = 'home'
  end

  def about
    @active_navigation = 'about'
  end

end
