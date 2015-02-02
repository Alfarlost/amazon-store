class Book < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
	validates :price, :title, :bookinstock, presence: true

    has_many :orderitems
	belongs_to :author
	belongs_to :category
end
