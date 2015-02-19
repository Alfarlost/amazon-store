class Book < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  validates :price, :title, :bookinstock, presence: true

    has_many :orderitems
    has_many :ratings
    belongs_to :author
    belongs_to :category

  def self.bestsellers(count)
    joins(:orderitems).group('books.id').order("sum(quantity) DESC").limit(count)
  end
end
