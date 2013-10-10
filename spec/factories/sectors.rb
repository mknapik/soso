FactoryGirl.define do
  factory :sector do
    name { Faker::Commerce::product_name }
    sector_group_id 1
  end
end

FactoryGirl.define do
  factory :sector_priority do
    priority 1
    sector 1
    user 1
  end
end

FactoryGirl.define do
  factory :sector_group do
    name 'IT'
  end
end
