FactoryGirl.define do
  factory :task, aliases: [:new_task] do
    sequence(:name) { |i| "Task-#{i}" }
    description { Faker::Lorem.sentence }
    user

    factory :invalid_task do
      name nil
    end

    factory :started_task do
      state 'started'
    end
    factory :finished_task do
      state 'finished'
    end

    factory :task_with_image do
      attachment { File.new("#{Rails.root}/spec/fixtures/test.jpg") }
    end
    factory :task_with_attachment do
      attachment { File.new("#{Rails.root}/spec/fixtures/examples.txt") }
    end
  end
end
