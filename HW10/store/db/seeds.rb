# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

categories = Category.create([
  { title: 'Phones',
    description: 'Category description' }
])

products = Product.create([
  { name: 'Iphone 14',
    description: 'iPhone 14 Pro has Dynamic Island, a magical new way to interact with iPhone.
                  And an Always-On display, which keeps your important info at a glance.',
    image: '/images/apple/iphone/14',
    price: 999.99, category_id: 1 }
])

User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password') 

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?