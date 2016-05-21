class Product < ActiveRecord::Base
  has_many :categories, through: :product_categories
  has_many :product_categories
  belongs_to :user
end
