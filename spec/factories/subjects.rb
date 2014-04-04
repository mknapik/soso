FactoryGirl.define do
  factory :subject do
    name { Faker::Name.title }
    committee
  end
end

FactoryGirl.define do
  factory :subject_grade do
    user nil
    subject
    grade 2.0
    ects 1.5
  end
end
