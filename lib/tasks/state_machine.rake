namespace :state_machine do
  describe 'Create state diagram for User.'
  task :user_diagram do
    ENV['CLASS'] = 'User'
    Rake::Task['state_machine:draw'].invoke
  end
end
