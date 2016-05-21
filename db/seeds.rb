# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = [
    { name: 'Jane Doe', phone: '(555) 555-5555', email: 'janedoe@gmail.com', password: '123456', password_confirmation: '123456'},
    { name: 'Jon Doe', phone: '(555) 555-5555', email: 'jondoe@gmail.com', password: '123456', password_confirmation: '123456'}
]

users.each do |user|
  User.create user
end

data_hash = JSON.parse(File.read(Rails.root.join('lib/products_data.json')))
data_hash.each do |item|
  product = Product.create(item.except('categories'))
  item['categories'].each do |category|
    product_categories = product.categories
    cat = Category.find_by_name category
    cat = product_categories.create name: category unless cat

    product_categories << cat unless product_categories.include? cat
  end
end

