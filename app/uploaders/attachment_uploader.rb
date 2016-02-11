# encoding: utf-8

class AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumbnail, if: :image? do
    process resize_to_limit: [500, 300]
  end

  private

  def image?(new_file)
    new_file.content_type.start_with?('image')
  end
end
