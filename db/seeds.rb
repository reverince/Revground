# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Users

User.create!(name:  "ADMIN",
             email: "a@test.com",
             password:              "1213",
             password_confirmation: "1213",
             admin: true)

33.times do |n|
  name  = Faker::Name.name + n.to_s
  email = "f#{n+1}@test.com"
  password = "1234"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# Microposts

users = User.order(:created_at).take(6)
33.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Relationships

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# The End

puts "[INFO] seeds.rb complete"
