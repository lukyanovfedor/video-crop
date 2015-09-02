class VideoUploader < CarrierWave::Uploader::Base

  VIDEO_WHITELIST = %w(mp4 avi)

  version :cropped, if: :ready_for_crop? do
    process :crop
  end

  def extension_white_list
    VIDEO_WHITELIST
  end

  def store_dir
    dir = Rails.env.test? ? 'test_uploads' : 'uploads'
    "#{dir}/#{model.class.to_s.underscore}/#{model.id}"
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def ready_for_crop
    @ready_for_crop = true
    self
  end

  def ready_for_crop?(_)
    @ready_for_crop
  end

  def crop
    VideoCropJob.perform_later(filename, model.id.to_s)
  end

  private

    def secure_token
      name = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(name) || model.instance_variable_set(name, SecureRandom.uuid)
    end

end
