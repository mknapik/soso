# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sector do
    name { Faker::Commerce::product_name }
    sector_group_id 1
  end
end
