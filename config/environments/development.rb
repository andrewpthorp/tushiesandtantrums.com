TushiesandtantrumsCom::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.asset_host = 'http://localhost:5000'
  config.action_mailer.default_url_options = { :host => 'localhost:5000' }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Expands the lines which load the assets
  config.assets.debug = true

  # Add the fonts path
  config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

  # Precompile additional assets
  config.assets.precompile += %w( .svg .eot .woff .ttf )
end
