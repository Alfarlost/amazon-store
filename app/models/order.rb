class Order < ActiveRecord::Base
	validates :state, inclusion: { in:  ["in progress", "complited", "shipped"] }

	has_many :orderitems
	belongs_to :customer
	before_save :update_total_price

	def total_price
	  orderitems.collect { |oi| oi.valid? ? (oi.price) : 0 }.sum
	end

	private
	  def update_total_price
	  	self[:total_price] = total_price
	  end

end
