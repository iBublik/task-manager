require 'rails_helper'

RSpec.describe Task, type: :model do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to belong_to(:user).inverse_of(:tasks) }

  describe '#final_state?' do
    subject { task.final_state? }

    context 'with new state' do
      let(:task) { build(:new_task) }

      it { is_expected.to be false }
    end

    context 'with started state' do
      let(:task) { build(:started_task) }

      it { is_expected.to be false }
    end

    context 'with finished state' do
      let(:task) { build(:finished_task) }

      it { is_expected.to be true }
    end
  end
end
