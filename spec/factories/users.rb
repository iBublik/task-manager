FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "user-#{i}@example.com" }
    role :user
    password 'qwerty123'

    factory :admin do
      role :admin
    end
  end
end
