source 'https://rubygems.org'

# Heroku uses the ruby version to configure your application's runtime.
ruby '2.0.0'

gem 'unicorn'
gem 'rails', '~> 4.0.0'
gem 'slim-rails'
gem 'jquery-rails'
gem 'devise' # for authentication
gem 'cancan' # for authorization
gem 'simple_form'
gem 'active_attr'
gem 'valid_email'
gem 'pg'
gem 'awesome_print'
gem 'rails-observers' # removed from 4.0, required by Spork
gem 'state_machine'
gem 'turbolinks' # boost page load time by reloading page with JS

# assets
gem 'less-rails'
gem 'less-rails-bootstrap'
group :production do
  gem 'uglifier'
end
gem 'coffee-rails'

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
  gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'rb-inotify'

  gem 'guard-migrate'
  gem 'guard-bundler'
  gem 'guard-annotate'
end

group :development do
  gem 'ruby-graphviz', :require => 'graphviz' # for state_machine graphs
  gem 'pry-rails'
  gem 'rails-erd'
  gem 'rack-mini-profiler'
  gem 'foreman'
  gem 'launchy'
  gem 'mailcatcher'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-rails'
                                              #  gem 'guard-jasmine'
  gem 'guard-livereload'
  gem 'rb-fsevent'
  gem 'libnotify' # for guard notification
end
