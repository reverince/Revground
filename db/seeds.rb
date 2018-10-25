# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "ADMIN",
             email: "a@test.com",
             password:              "1213",
             password_confirmation: "1213",
             admin: true)

33.times do |n|
  name  = Faker::Name.name
  email = "f#{n+1}@test.com"
  password = "1234"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

puts "seeds.rb 실행 완료"
