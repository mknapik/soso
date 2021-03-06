# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :city do
    country_id 1
    sequence(:name) { |n| "City #{n}" }
  end

  factory :committee do
    city_id 1
    sequence(:name) { |n| "Committee #{n}" }
    sequence(:code) { |n| "#{n}" }
  end

  factory :country do
    sequence(:name) { |n| "Country #{n}" }
    sequence(:code) { |n| "#{n}" }
  end
end
