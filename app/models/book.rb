class Book < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  validates :price, :title, :description, :bookinstock, presence: true

    has_many :orderitems
    has_many :ratings
    belongs_to :author
    belongs_to :category

  before_save :set_small_description

  def self.bestsellers(count)
    joins(:orderitems).group('books.id').order("sum(quantity) DESC").limit(count)
  end

  def set_small_description
    self.small_description = "#{self.description.first(150)}..."
  end
end
