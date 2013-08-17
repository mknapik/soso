# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role_admin, class: Role do
    id 1
    name 'admin'
  end
end
