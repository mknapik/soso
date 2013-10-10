FactoryGirl.define do
  factory :polish do
    code 'pol'
    name 'Polish'
  end
  factory :english do
    code 'eng'
    name 'English'
  end
  factory :language do
    code Faker::Name::name[0..3]
    name Faker::Name::name
  end
end
