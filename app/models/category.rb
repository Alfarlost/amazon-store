class Category < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	validates :title, presence: true, uniqueness: true

	has_many :books
end
