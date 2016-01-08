class Slide < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	belongs_to :user
end
