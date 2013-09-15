if Rails.env.production?
  ActionMailer::Base.asset_host                 = 'http://www.tushiesandtantrums.com'
  ActionMailer::Base.default_url_options[:host] = 'tushiesandtantrums.com'
else
  ActionMailer::Base.asset_host                 = 'http://localhost:5000'
  ActionMailer::Base.default_url_options[:host] = 'localhost:5000'
end
