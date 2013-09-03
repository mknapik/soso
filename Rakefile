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
  namespace :hard do
    task :setup do
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:seed'].invoke
      Rake::Task['db:sample_data'].invoke
    end
    task :reset do
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:hard:setup'].invoke
    end
  end
end
namespace :state_machine do
  task :user_diagram do
    Rake::Task['state_machine:draw CLASS=User'].invoke
  end
end
