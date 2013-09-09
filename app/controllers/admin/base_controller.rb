class Admin::BaseController < ::ApplicationController
  layout 'admin'

  # Internal: All actions that are performed in an admin controller require that
  # an Admin is logged in.
  before_filter :authenticate_admin!
end
