class User < ActiveRecord::Base
  has_secure_password

  enum role: %i(user admin)

  validates :email, presence: true, uniqueness: true

  has_many :tasks, inverse_of: :user, dependent: :destroy
end
