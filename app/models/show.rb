class Show < ApplicationRecord
	mount_base64_uploader :image, ImageUploader

	belongs_to :user
	has_many   :podcasts, dependent: :destroy

	validates_presence_of :name
end
