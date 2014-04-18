ENV['RAILS_ENV'] ||= 'test'
require 'rubygems'

# Export RUBYMINE_HOME variable before using spork/guard
# to enable running tests with external spork server inside Rubymine.
if ENV['RUBYMINE_HOME']
  $LOAD_PATH.unshift(File.expand_path('rb/testing/patch/common', ENV['RUBYMINE_HOME']))
  $LOAD_PATH.unshift(File.expand_path('rb/testing/patch/bdd', ENV['RUBYMINE_HOME']))
end
ENV['RAILS_ENV'] ||= 'test'

if ENV['COVERAGE'] == '1'
  require 'simplecov'
  require 'metric_fu/metrics/rcov/simplecov_formatter'
  require 'simplecov-rcov'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::RcovFormatter,
      SimpleCov::Formatter::MetricFu,
  ]
  SimpleCov.start 'rails'
end

if ENV['CODE_CLIMATE']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
end

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/email/rspec'
require 'cancan/matchers'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Poltergeist config
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: true, inspector: true)
end

Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :rack_test

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Use the new expect() syntax.
  # - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
  # - http://teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.add_setting(:seed_tables)
  config.seed_tables = %w(roles term_states choice_states stages statuses sectors sector_groups)
end

# Turn down the logging while testing.
Rails.logger.level = 4
