ActiveAdmin.register User do
    permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :_name, :picture

    index do
        column :name
        column :email
        column "Tweets" do |i|
        i.tweets.count
      end
      column "Likes" do |i|
        i.likes.count
      end
      column "Friends" do |i|
        i.friends.count
      end
      actions
    end
    
  end