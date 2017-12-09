# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
categories = []
3.times {categories << Category.create(name: Faker::Book.genre)}

10.times do
  Book.create!(
    title: Faker::Book.title,
    year: (1800..2017).to_a.sample,
    isbn: Faker::Number.number(13),
    category: categories.sample
  )
end
