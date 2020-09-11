require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'mknigram-photo'
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIA2ZDXLFCVMK7ZL66W',
      aws_secret_access_key: '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',
      region: 'ap-northeast-1',
      path_style: true
    }
end
