FactoryGirl.define do
  factory :exam do
    language
    datetime '2013-10-10 11:02:54'
    min 5
    max 15
    state 'open'
  end
end
