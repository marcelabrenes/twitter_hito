# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Like.destroy_all
Tweet.destroy_all
User.destroy_all

# 25.times do |i|
#     user = User.create(name: Faker::Twitter.name, email: "example#{i}@example.com", password: '123456')
#     puts "Created user: #{user.name}"

#     4.times do |i|
#         tweet = Tweet.new(content: Faker::Twitter.status.text, user_id: user.id) 
#         # tweet = user.tweets.build(content: Faker::Twitter.status,
#         # date: Faker::Date.between(from:'2019-01-01', to: Date.today)

#         tweet.save
#         puts "Tweet in: #{tweet.content}"
#     end
# end

# 25.times do |i|
#     user = User.create(name: Faker::Twitter.name, email: "example#{i}@example.com", password: '123456')

#     4.times do |i|
#         tweet = Tweet.create(content:"Contenido#{i}"), user_id: user.id)
#         tweet.save
#         puts "Tweet in: #{tweet.content}"
#     end
# end

25.times do 
    user = User.create(name: Faker::Twitter.user[:name], email: Faker::Internet.email, password: 123123, picture: Faker::Twitter.user[:profile_image_url_https])
    puts "The #{user.name} was created"
    4.times do
        tweet = Tweet.create!(content: Faker::Twitter.status[:text], user: user)
        puts "The #{tweet.id} was created"
    end    
end    AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?