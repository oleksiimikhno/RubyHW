# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'

Product.destroy_all
Category.destroy_all
User.destroy_all
AdminUser.destroy_all

5.times do
  Category.create(
    title: Faker::Commerce.material,
    description: Faker::Lorem.paragraph(sentence_count: 2)
  )
end

12.times do
  product = Product.create(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    price: Faker::Commerce.price(range: 0..10.0, as_string: true),
    category_id: rand(Category.first.id..Category.last.id)
  )

  product.image.attach(
    io: File.open(Rails.root.join('app/assets/images/default_product.jpg')),
    filename: 'default_product.jpg'
  )
end

User.create!(email: 'user@example.com', password: 'password', password_confirmation: 'password')

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?