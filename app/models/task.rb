class Task < ActiveRecord::Base
  include Workflow

  mount_uploader :attachment, AttachmentUploader

  IMAGE_FORMATS = /jpg|png|gif|jpeg/

  belongs_to :user, inverse_of: :tasks

  validates :user_id, :name, presence: true

  workflow_column :state
  workflow do
    state :new do
      event :start, transitions_to: :started
    end
    state :started do
      event :finish, transitions_to: :finished
    end
    state :finished
  end

  def final_state?
    current_state.events.empty?
  end

  def switch_state
    can_start? ? start! : finish!
  end

  def image_attachment?
    attachment? && File.extname(attachment.file.identifier) =~ IMAGE_FORMATS
  end
end
