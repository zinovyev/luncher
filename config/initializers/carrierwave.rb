CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_provider = 'fog/aws'                        # required
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],     # required
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'], # required
      aws_region:            ENV['AWS_REGION'],
    }
    config.fog_directory  = 'luncher'                      # required
  else
    config.storage :file
  end
end
