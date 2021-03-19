class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :likes, dependent: :destroy
  has_many :friends

  scope :tweets_for_me, ->(friends_ids) { Tweet.where(user_id: friends_ids) }
  
  def is_friend_with(user)
    Friend.where(user_id: self.id, friend_id: user.id).present? 
  end
  
  
end
