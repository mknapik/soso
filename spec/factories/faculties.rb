# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :faculty do
    committee_id 1
    sequence(:name) { |n| "Faculty #{n}" }
  end

  factory :field_of_study do
    faculty_id 1
    sequence(:name) { |n| "Field of Study #{n}" }
  end

  factory :specialization do
    field_of_study_id 1
    sequence(:name) { |n| "Specialization #{n}" }
  end
end
