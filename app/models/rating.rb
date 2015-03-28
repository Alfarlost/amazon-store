class Rating < ActiveRecord::Base
  validates :review, :rating, presence: true
  belongs_to :customer
  belongs_to :book

  include AASM

  aasm do # default column: aasm_state
    state :not_approved, :initial => true
    state :approved

    event :approve do
      transitions :from => :not_approved, :to => :approved
    end
  end

  def rater_name  
    if self.customer.billing_address.first_name.present?
      "#{self.customer.billing_address.first_name}"
    elsif self.customer.billing_address.last_name.present?
      "#{self.customer.billing_address.last_name}"
    else
      "Anonymous"
    end
  end

  def set_customer(customer)
    self.customer_id = customer.id
    self.save
  end
end
