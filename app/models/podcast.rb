class Podcast < ApplicationRecord
  mount_base64_uploader :audio, AudioUploader

  belongs_to :show
  # validates_presence_of :audio
end
