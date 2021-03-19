class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, class_name: "Tweet", foreign_key: "retweet_id"
  belongs_to :retweet, class_name: "Tweet", optional: true
  validates :content, presence: true
   def hashtag_search()
    content.split(' ').each do |word|
      puts word
    end
    content[0]
   end
end
