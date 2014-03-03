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

    trait :year do
      name 'year'
      value Time.now.year
      year 0
    end
  end
end
