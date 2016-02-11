FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user-#{i}@example.com" }
    role :user
    password 'qwerty123'
  end
end
