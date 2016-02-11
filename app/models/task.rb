class Task < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader

  belongs_to :user, inverse_of: :tasks

  validates :user_id, :name, presence: true
end
