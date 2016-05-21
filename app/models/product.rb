class Product < ActiveRecord::Base
  has_many :categories, through: :product_categories
end
