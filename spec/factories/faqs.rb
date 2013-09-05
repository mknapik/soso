# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :faq do
    question Faker::Lorem::sentence(10)
    answer Faker::Lorem::paragraph(5)
    committee
  end
end
