FactoryGirl.define do
  factory :task do
    sequence(:name) { |i| "Task-#{i}" }
    description { Faker::Lorem.sentence }
    user

    factory :invalid_task do
      name nil
    end
  end
end
