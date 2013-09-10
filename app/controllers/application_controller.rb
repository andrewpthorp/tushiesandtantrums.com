class ApplicationController < ActionController::Base
  protect_from_forgery

  # Internal: Set the headers used for AJAX requests.
  #
  # type    - The type of header to set. Will be set as 'Ajax-Type'.
  # opts    - Hash of extra headers to set (default: {}, optional).
  #
  # Returns nothing.
  def set_headers(type, opts={})
    response.headers['Ajax-Type'] = type

    opts.each do |k, v|
      response.headers[k.to_s] = v
    end
  end

  # Internal: Override the default Devise after_sign_in_path_for.
  #
  # Returns a String.
  def after_sign_in_path_for(resource)
    admin_products_path
  end

end
