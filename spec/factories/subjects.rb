# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subject do
    name { Faker::Name::title }
    committee
  end
end

FactoryGirl.define do
  factory :subject_grade do
    user nil
    subject
    grade 1.5
    ects 1.5
  end
end
