FactoryGirl.define do
  sequence :student_no do |n|
    (228000+n).to_s
  end
  sequence(:random_string) {|n|  }

  factory :user do
    role_id 5

    trait :registered do
      student_no
      name { Faker::Name::first_name }
      surname { Faker::Name::last_name }
      email { "#{name}.#{surname}@example.com".downcase }
      committee_id 5
      password 'secret123'
      password_confirmation { |u| u.password }
    end
    trait :confirmed do
      zip '12-123' # Faker::Address::zip
      city Faker::Address::city
      house Faker::Address::zip.to_i
      birth_date 21.years.ago
      field_of_study_id 1
      faculty_id 1
      specialization_id 1
      study_year 2
      phone '546 234 123' # Faker::PhoneNumber::cell_phone
      # required if the Devise Confirmable module is used
      confirmed_at Time.now
    end
    trait :admin do
      role_id 2
    end
    trait :editor do
      role_id 4
    end
    trait :manager do
      role_id 3
    end

    factory :confirmed_user, traits: :confirmed
  end
end

