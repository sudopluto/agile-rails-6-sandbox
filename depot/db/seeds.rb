# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
Product.delete_all

Product.create!(
  title: 'apple',
  description: %{<p>
    Apples taste good and you can shoot arrows into them!
  </p>},
  image_url: 'apple.jpg',
  price: 2.99
)
