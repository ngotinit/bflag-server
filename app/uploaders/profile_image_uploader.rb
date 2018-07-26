class ProfileImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    'fallback/' + [version_name, 'default_image.png'].compact.join('_')
  end

  version :thumb do
    process resize_to_fit: [100, 100]
  end

  version :preview do
    process resize_to_fit: [300, 300]
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

  def filename
    "#{model.username}_profile_image" + File.extname(super)
  end
end
