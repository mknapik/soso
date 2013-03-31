source 'https://rubygems.org'

# Heroku uses the ruby version to configure your application's runtime.
ruby '2.0.0'

gem 'unicorn'
gem 'rails', '4.0.0.beta1'
#gem 'rails', github: 'rails/rails'
gem 'slim-rails'
gem 'jquery-rails'
#gem 'devise' # for authentication
gem 'devise', :git => 'git://github.com/plataformatec/devise.git', :branch => 'rails4'
gem 'sorcery' # remove me
gem 'cancan' # for authorization
#gem 'simple_form', '3.0.0.beta1'
gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'
gem 'active_attr'
gem 'valid_email'
gem 'pg'
gem 'awesome_print'
gem 'protected_attributes' #deprecated
gem 'rails-observers' # removed from 4.0, required by Spork

# assets
gem 'less-rails'
gem 'less-rails-bootstrap'
gem 'uglifier'
gem 'coffee-rails', '~> 4.0.0.beta1'

# Heroku suggests that these gems aren't necessary, but they're required to compile less assets on deploy.
gem 'therubyracer'
gem 'libv8', '~> 3.11.8'

group :test, :development do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-email'
  gem 'factory_girl_rails'
#  gem 'jasminerice'
  gem 'timecop'
  gem 'simplecov'
  gem 'cane'
  gem 'morecane'
  gem 'quiet_assets'
  gem 'spork'
  gem 'spork-rails', github: 'mknapik/spork-rails' # contains fixes for Rails 4.0
  gem 'rb-inotify'
  gem 'email_spec'
end

group :development do
  gem 'foreman'
  gem 'launchy'
  gem 'mailcatcher'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'
#  gem 'guard-jasmine'
  gem 'guard-livereload'
  gem 'rb-fsevent'
  gem 'libnotify' # for guard notification
end
