# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sector_priority do
    priority 1
    sector 1
    user 1
  end
end
