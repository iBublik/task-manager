def create_users
  %i(user admin).each do |role|
    User.where(email: "#{role}@example.com").first_or_create!(
      role: role, password: 'qwerty123'
    )
  end
end

create_users
