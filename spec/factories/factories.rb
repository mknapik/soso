# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :stage do
    name 'stage_1'
    full_name 'Stage 1'
    description 'this stage'
    deadline Time.now
    committee
  end
end

FactoryGirl.define do
  factory :setting do
    name 'setting 1'
    value 'value 1'
    year Time.now.year
    committee
  end
end
