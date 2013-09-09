# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :polish do
    code 'pol'
    name 'Polish'
  end
  factory :language do
    code Faker::Name::name[0..3]
    name Faker::Name::name
  end
end
