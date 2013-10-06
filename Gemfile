# A sample Gemfile
source "https://rubygems.org"
ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'carrierwave'
gem 'devise'
gem 'pg', require: 'pg'
gem 'foreman'
gem 'unicorn'
gem 'mini_magick'
gem 'fog', '~> 1.3.1'
gem 'faker'
gem 'factory_girl_rails'
gem 'zurb-foundation'
gem 'jquery-rails'
gem 'haml'
gem 'sass'
gem 'bourbon'
gem 'money-rails'
gem 'acts-as-taggable-on'
gem 'stripe'
gem 'carmen-rails', git: 'https://github.com/jim/carmen-rails.git'
gem 'friendly_id', git: 'https://github.com/norman/friendly_id.git'
gem 'redcarpet'
gem 'kaminari'
gem 'newrelic_rpm'
gem 'nested_form'
gem 'dalli'
gem 'memcachier'
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier'

group :production do
  gem 'rails_12factor' # heroku!
end

group :development do
  gem 'letter_opener'
  gem 'guard', git: 'https://github.com/guard/guard.git'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'quiet_assets'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'stripe-ruby-mock', '>= 1.8.4.9'
  gem 'capybara'
  gem 'database_cleaner', '>= 0.6.7'
  gem 'shoulda-matchers'
end
