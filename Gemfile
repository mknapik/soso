source 'https://rubygems.org'

# Heroku uses the ruby version to configure your application's runtime.
ruby '2.0.0'

gem 'unicorn'
gem 'rack-canonical-host'
gem 'rails', '~> 4.0.0'
gem 'devise' # for authentication
gem 'cancan' # for authorization
gem 'active_attr'
gem 'valid_email'
gem 'pg'
gem 'awesome_print'
gem 'rails-observers' # removed from 4.0, required by Spork
gem 'state_machine'

# assets
gem 'slim-rails'
gem 'less-rails'
gem 'less-rails-bootstrap'
gem 'jquery-rails'
gem 'coffee-rails'
gem 'turbolinks' # boost page load time by reloading page with JS
gem 'simple_form', github: 'plataformatec/simple_form'
gem 'uglifier'

gem 'awesome_print'

# Heroku suggests that these gems aren't necessary, but they're required to compile less assets on deploy.
gem 'therubyracer', platforms: :ruby
#gem 'libv8'#, '~> 3.11.8'

group :test, :development do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'capybara-email'
  gem 'poltergeist'
  gem 'factory_girl_rails'
  gem 'fuubar'
  gem 'jasminerice', github: 'bradphelan/jasminerice' # Latest release still depends on haml.
                                                      #gem 'timecop'
  gem 'simplecov'
  gem 'cane'
  gem 'morecane'
  gem 'quiet_assets'
  gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'rb-inotify'

  gem 'guard'
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
  gem 'mailcatcher' # just type `mailcatcher` to run simple SMTP server (see mails at localhost:1080)
  gem 'better_errors' # shows verbose error messages if action fails
  gem 'binding_of_caller' # provides additional info for better_errors
  gem 'meta_request' # for Chrome RailsPanel Extension
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-rails'
  gem 'guard-jasmine'
  gem 'guard-livereload'
  gem 'rb-fsevent'
  gem 'libnotify' # for guard notification
  gem 'zeus'
end
