require 'rails_helper'

RSpec.describe Task, type: :model do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to belong_to(:user).inverse_of(:tasks) }
end
