FactoryGirl.define do
  factory :faq do
    question Faker::Lorem.sentence(10)
    answer Faker::Lorem.paragraph(5)
    committee
  end
end
