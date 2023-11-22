# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

10.times do |i|
  User.create(
    email: "user#{i+1}@example.com",
    password: "password#{i+1}",
    name: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    username: Faker::Internet.username(specifier: 5..8),
    age: rand(18..60),
    avatar: Faker::Avatar.image(slug: "avatar-#{rand(1..100)}", size: "300x300", format: "png"),
    description: Faker::Lorem.paragraph(sentence_count: 2)
  )
end
