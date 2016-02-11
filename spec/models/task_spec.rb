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

  describe '#image_attachment?' do
    subject { task.image_attachment? }

    context 'with attachment that has image extension' do
      let(:task) { build(:task_with_image) }

      it { is_expected.to be_truthy }
    end

    context 'with attachment that has not image extension' do
      let(:task) { build(:task_with_attachment) }

      it { is_expected.to be_falsy }
    end

    context 'with no attachment' do
      let(:task) { build(:task) }

      it { is_expected.to be_falsy }
    end
  end
end
