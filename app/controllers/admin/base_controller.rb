# Internal: The base controller for all admin controllers to inherit from. This
# controller will do simple setup that every admin controller needs:
# authentication, use the right layout, etc.
#
# Examples
#
#   class Admin::ChargesController < Admin::BaseController
#   end
class Admin::BaseController < ::ApplicationController
  # Internal: Use the 'admin' layout.
  layout 'admin'

  # Internal: All actions that are performed in an admin controller require that
  # an Admin is logged in.
  before_filter :authenticate_admin!
end
