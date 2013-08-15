# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    name 'Tom'
    surname 'Middleton'
    password 'password'

    factory :admin do
      name 'Admin'
      role_id 1

    end
  end
end
