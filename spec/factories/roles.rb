FactoryGirl.define do
  factory :role_admin, class: Role do
    id 1
    name 'admin'
  end
  factory :role do
    id 5
    name 'user'
  end
end
