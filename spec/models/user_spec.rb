require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_secure_password }

  it { is_expected.to define_enum_for(:role).with(%i(user admin)) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }

  it { is_expected.to have_many(:tasks).inverse_of(:user).dependent(:destroy) }
end
