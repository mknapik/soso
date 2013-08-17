# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :city do
    country_id 1
    sequence(:name) { |n| "City #{n}" }
  end

  factory :committee do
    city_id 1
    sequence(:name) { |n| "Committee #{n}" }
  end

  factory :country do
    sequence(:name) { |n| "Country #{n}" }
  end
end
