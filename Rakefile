#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Soso::Application.load_tasks

# Disable schema.sql generation, unless we're in development.
# http://stackoverflow.com/questions/12413306/error-when-doing-rake-dbmigrate-on-heroku
Rake::Task['db:structure:dump'].clear unless Rails.env.development?

# Spec is the default rake target.
task(:default).clear
task default: 'spec'

namespace :db do
  task :annotate do
    exec 'annotate -f rdoc -m -s -i -e tests,fixtures,factories'
  end
end

task :generate_state_diagram do
  Rake::Task['state_machine:draw CLASS=Vehicle'].invoke
end

namespace :db do
  namespace :config do
    task :init, :database, :username, :password do |t, args|
      puts args.inspect
      unless [:database, :username, :password].all? { |arg| puts arg; args.include? arg }
        raise RuntimeError.new("specify all arguments: 'database', 'username' and 'password'")
      end
      default_config = YAML.load_file('config/database.example.yml')
      default_config.each do |env, settings|
        settings[:database] = "#{args[:database]}_#{env}"
        settings[:username] = args[:username]
        settings[:password] = args[:password]
      end
      File.write('config/database.yml', default_config.to_yaml)
    end
  end
end
