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

25.times do 
    user = User.create(name: Faker::Twitter.user[:name], email: Faker::Internet.email, password: 123123, picture: Faker::Twitter.user[:profile_image_url_https])
    puts "The #{user.name} was created"
    6.times do
        tweet = Tweet.create!(content: Faker::Twitter.status[:text], image: Faker::LoremFlickr.image["https://loremflickr.com/300/300"], user: user)
        puts "The #{tweet.id} was created"
    end   
end
