# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Nam Pham",
             email: "nampham@bu.edu",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             confirmed_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               confirmed_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
10.times do
  content = Faker::Lorem.sentence(5)
  users.each do |user| 
    post = user.posts.create!(content: content, to_post: Time.zone.now, 
                              posted_at: Time.zone.now, approved: true, 
                              post_date: Date.today)
  end
end

users = User.order(:created_at).take(6)
10.times do
  content = Faker::Lorem.sentence(5)
  users.each do |user| 
    post = user.posts.create!(content: content, to_post: Time.zone.now, 
                              posted_at: 1.day.ago, approved: true, 
                              post_date: Date.yesterday)
  end
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each do |user| 
    post = user.posts.create!(content: content, to_post: Time.zone.now)
  end
end