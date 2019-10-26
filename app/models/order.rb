class Order < ApplicationRecord
  has_many :order_items
  
  validates :order_items, :length => { :minimum => 1 }, unless: Proc.new { |o| o.status == 'pending' }
  validates :email, presence: true, unless: Proc.new { |o| o.status == 'pending' }
  # Default email validation REGEX from https://api.rubyonrails.org/v5.1/classes/ActiveModel/Validations/ClassMethods.html#method-i-validates 
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, unless: Proc.new { |o| o.status == 'pending' }
  validates :name, presence: true, unless: Proc.new { |o| o.status == 'pending' }
  validates :owling_address, presence: true, unless: Proc.new { |o| o.status == 'pending' }
  validates :cc_num, presence: true, unless: Proc.new { |o| o.status == 'pending' }
  validates :cc_exp_mo, presence: true, unless: Proc.new { |o| o.status == 'pending' }
  validates :cc_exp_yr, presence: true, unless: Proc.new { |o| o.status == 'pending' }
  validates :cc_cvv, presence: true, unless: Proc.new { |o| o.status == 'pending' }
  validates :zip_code, presence: true, unless: Proc.new { |o| o.status == 'pending' }
  validates :status, presence: true
  
  def total
    return self.order_items.reduce(0) { |sum, item| sum + item.subtotal }
  end
end
