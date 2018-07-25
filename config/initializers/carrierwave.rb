CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  end

  if Rails.env.production?
    config.storage = :fog
  end

  config.fog_credentials = {
    provider:                         'Google',
    google_storage_access_key_id:     ENV['google_storage_access_key_id'],
    google_storage_secret_access_key: ENV['google_storage_secret_access_key']
  }
  config.fog_directory = 'avatars'
end
