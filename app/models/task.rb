class Task < ActiveRecord::Base
  mount_uploader :attachments, AttachmentUploader

  belongs_to :user, inverse_of: :tasks

  validates :user_id, :name, presence: true
end
