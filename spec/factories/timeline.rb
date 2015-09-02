FactoryGirl.define do
  factory :timeline do
    skip_create

    from 10
    to 20

    initialize_with { new(from, to) }
  end
end
