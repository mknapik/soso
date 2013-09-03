source 'https://rubygems.org'

# Heroku uses the ruby version to configure your application's runtime.
ruby '2.0.0'

gem 'unicorn', require: false
gem 'thin', require: false

#- gem 'rack-canonical-host' # middleware for defining a canonical host name; not sure why needed
gem 'rails', '~> 4.0.0'
gem 'devise'               # for authentication
#? gem 'seed-fu', github: 'mbleigh/seed-fu' # provides advanced seed and fixtures system
gem 'cancan'               # for authorization
gem 'valid_email', :require => 'valid_email/email_validator' # validation for email
gem 'pg'
gem 'awesome_print'        # pretty prints Ruby objects in full color
gem 'rails-observers'      # removed from 4.0, required by Spork
gem 'state_machine'
gem 'select2-rails'        # e.g. sectors multiselect
gem 'acts_as_list'         # for ordering subject grades
gem 'bootstrap-datepicker-rails'
#- gem 'active_model_serializers' # for custom json serialization
gem 'figaro'               # used for keeping secret data private
gem 'google-analytics-rails', group: :production

# assets
gem 'slim-rails'
gem 'less-rails'
#gem 'less-rails-bootstrap', '3.0.0.rc1', github: 'metaskills/less-rails-bootstrap', branch: '3.0.0-rc1'
gem 'less-rails-bootstrap', '<3.0.0'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'coffee-rails'
gem 'turbolinks'           # boost page load time by reloading page with JS
gem 'simple_form', github: 'plataformatec/simple_form'
gem 'uglifier'
gem 'nprogress-rails'

# Heroku suggests that these gems aren't necessary, but they're required to compile less assets on deploy.
gem 'therubyracer', platforms: :ruby
gem 'libv8', '~> 3.11.8'
gem 'rails_12factor', group: :production # required by heroku for Rails 4.0

group :test, :development do
  gem 'railroady'

  gem 'phantomjs'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'capybara-email'
  gem 'poltergeist'        # WebKit tests with Capybara
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'fuubar'
#-  gem 'jasminerice', github: 'bradphelan/jasminerice' # Latest release still depends on haml.
# gem 'timecop'            # provides "time travel, freezing and acceleration" capabilities for tests

# code quality
  gem 'simplecov'
  gem 'simplecov-rcov-text'
  gem 'cane'               # code quality threshold checking
  gem 'morecane'

  gem 'quiet_assets'
  gem 'rb-inotify'

# guard
  gem 'guard'              # automatically run various tasks depending on file changes
  gem 'guard-bundler'      # runs `bundle install` on Gemfile changes
  gem 'guard-annotate'     # annotates model classes on schema changes
end

group :development do
  gem 'rails-erd'          # generates ERD from model (`rake erd`)
  gem 'ruby-graphviz'      # for state_machine graphs

  gem 'pry-rails'          # (more than) an IRB replacement
  gem 'rack-mini-profiler' # displays profiler in left upper corner
  gem 'foreman'
#  gem 'mailcatcher'       # runs simple SMTP server (run `mailcatcher` and see mails at localhost:1080)
# debugging
  gem 'better_errors'      # shows verbose error messages if action fails
  gem 'binding_of_caller'  # provides additional info for better_errors
  gem 'meta_request'       # for Chrome RailsPanel Extension

# guard
  gem 'guard-rspec'
#-  gem 'guard-rails'      # automatically runs rails server
#-  gem 'guard-jasmine'    # JS BDD
  gem 'guard-livereload'   # reloads the browser after each change (browser plugin is required)
  gem 'rb-fsevent'
  gem 'libnotify'          # for guard notification

  gem 'spring'
end
