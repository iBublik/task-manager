namespace :task_tracker do
  task populate_data: :environment do
    files = %w(examples.txt test.jpg).map do |file|
      Rails.root.join('spec/fixtures', file).open
    end
    10.times do
      user = User.where(email: Faker::Internet.email).first_or_create!(
        password: Faker::Internet.password
      )
      5.times do
        user.tasks.create!(
          name: Faker::Lorem.sentence, description: Faker::Lorem.paragraphs.join(' '),
          attachment: files.sample
        )
      end
    end
  end
end
