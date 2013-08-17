# Populate the database with a small set of realistic sample data so that as a developer/designer, you can use the
# application without having to create a bunch of stuff or pull down production data.
#
# After running db:sample_data, a developer/designer should be able to fire up the app, sign in, browse data and see
# examples of practically anything (interesting) that can happen in the system.
#
# It's a good idea to build this up along with the features; when you build a feature, make sure you can easily demo it
# after running db:sample_data.
#
# Data that is required by the application across all environments (i.e. reference data) should _not_ be included here.
# That belongs in seeds.rb instead.

# TODO Disable sending emails, no need for seed data.

[:admin, :manager, :staff, :user].each do |role|
  Role.where(name: :admin).first_or_create
end

users = []

users << User.where(email: 'admin@example.com', name: 'admin', surname: 'admin').first_or_initialize

users << User.where(email: 'mike@example.com', name: 'Mike', surname: 'Smith').first_or_initialize

users.each do |user|
  user.password = 'password'
  user.confirmed_at = Time.now
  user.save!
end