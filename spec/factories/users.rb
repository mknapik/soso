# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :index do |n|
    (228000+n).to_s
  end
  sequence(:random_string) {|n|  }

  factory :user do
    role_id 5
    #status_id 1
    #committee_id 1

    trait :registered do
      index
      name { Faker::Name::first_name }
      surname { Faker::Name::last_name }
      email { "#{name}.#{surname}@example.com".downcase }
      password 'secret'
      password_confirmation { |u| u.password }
    end
    trait :confirmed do
      #zip Faker::Address::zip
      #city Faker::Address::city
      #house Faker::Address::zip.to_i
      #birth_date 21.years.ago
      #course_id 1
      #faculty_id 1
      #specialization_id 1
      #tel Faker::PhoneNumber::cell_phone
      ## required if the Devise Confirmable module is used
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

