namespace :db do
  desc 'Load a small, representative set of data so that the application can start in an use state (for development).'
  task sample_data: :environment do
    sample_data = File.join(Rails.root, 'db', 'sample_data.rb')
    load(sample_data) if sample_data
  end

  desc 'Annotate models with schema information.'
  task :annotate do
    exec 'annotate -f rdoc -m -s -i -e tests,fixtures,factories'
  end

  namespace :hard do
    'Creates database with migrations and seeds sample data.'
    task :setup do
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:seed'].invoke
      Rake::Task['db:sample_data'].invoke
    end

    'Drops the database and then does hard:setup.'
    task :reset do
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      Rake::Task['db:hard:setup'].invoke
    end
  end
end
