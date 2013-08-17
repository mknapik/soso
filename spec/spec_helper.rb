ENV['RAILS_ENV'] ||= 'test'
require 'rubygems'
require 'spork'

# Coverage must be enabled before the application is loaded.
if ENV['COVERAGE']
  require 'simplecov'

  # Writes the coverage stat to a file to be used by Cane.
  class SimpleCov::Formatter::QualityFormatter
    def format(result)
      SimpleCov::Formatter::HTMLFormatter.new.format(result)
      File.open('coverage/covered_percent', 'w') do |f|
        f.puts result.source_files.covered_percent.to_f
      end
    end
  end
  SimpleCov.formatter = SimpleCov::Formatter::QualityFormatter

  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/config/'
    add_filter '/vendor/'
    add_group 'Models', 'app/models'
    add_group 'Controllers', 'app/controllers'
    add_group 'Helpers', 'app/helpers'
    add_group 'Views', 'app/views'
    add_group 'Mailers', 'app/mailers'
  end
end

Spork.prefork do
  # Export RUBYMINE_HOME variable before using spork/guard
  # to enable running tests with external spork server inside Rubymine.
  if ENV['RUBYMINE_HOME']
    $:.unshift(File.expand_path('rb/testing/patch/common', ENV['RUBYMINE_HOME']))
    $:.unshift(File.expand_path('rb/testing/patch/bdd', ENV['RUBYMINE_HOME']))
  end
  ENV['RAILS_ENV'] ||= 'test'
  if ENV['COVERAGE'] == '1'
    require 'simplecov'
    require 'simplecov-rcov-text'
    class SimpleCov::Formatter::MergedFormatter
      def format(result)
        SimpleCov::Formatter::HTMLFormatter.new.format(result)
        SimpleCov::Formatter::RcovTextFormatter.new.format(result)
      end
    end
    SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter
    SimpleCov.start
  end
  require File.expand_path('../../config/environment', __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/email/rspec'
  require 'cancan/matchers'

  # Prevent Devise from loading the User model super early with it's route hacks for Rails 3.1 rc4
  # see also: https://github.com/timcharper/spork/wiki/Spork.trap_method-Jujutsu
  Spork.trap_method(Rails::Application, :reload_routes!)
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
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

  # Forces all threads to share the same connection. This works on
  # Capybara because it starts the web server in a thread.
  #
  # http://blog.plataformatec.com.br/2011/12/three-tips-to-improve-the-performance-of-your-test-suite/
end


# Turn down the logging while testing.
Rails.logger.level = 4

Spork.each_run do
  # This code will be run each time you run your specs.
  require 'factory_girl_rails'

  class ActiveRecord::Base
    mattr_accessor :shared_connection
    @@shared_connection = nil

    def self.connection
      @@shared_connection || retrieve_connection
    end
  end

  ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
end