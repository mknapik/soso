# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role, :class => 'Roles' do
    name "MyString"
  end
end
