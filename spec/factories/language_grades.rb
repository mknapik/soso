# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :language_grade do
    user nil
    language nil
    grade 1.5
    year 1
    paid false
  end
end
