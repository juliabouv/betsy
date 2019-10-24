class Product < ApplicationRecord
  belongs_to :wizard
  has_many :reviews
  has_many :order_items
  has_and_belongs_to_many :categories
end
