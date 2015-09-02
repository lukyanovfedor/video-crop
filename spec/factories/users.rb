FactoryGirl.define do
  factory :user do
    api_key { FactoryGirl.build :api_key }
  end
end
