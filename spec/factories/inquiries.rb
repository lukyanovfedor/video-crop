FactoryGirl.define do
  factory :inquiry do
    video { FactoryGirl.build :video }
    user
  end
end
