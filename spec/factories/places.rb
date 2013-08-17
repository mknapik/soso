# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :city do
    country_id 1
    sequence(:name) do |n|
      "City #{n}"
    end
  end
  factory :committee do
    city_id 1
    sequence(:name) do |n|
      "Committee #{n}"
    end
  end
  factory :country do
    sequence(:name) do |n|
      "Country #{n}"
    end
  end
end
