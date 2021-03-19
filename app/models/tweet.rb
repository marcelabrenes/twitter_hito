class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, class_name: "Tweet", foreign_key: "retweet_id"
  belongs_to :retweet, class_name: "Tweet", optional: true
  validates :content, presence: true
  
  #  def hashtag(tweet)
  #    hastags = content.split(' ')
  #    palabras.each
  #    content
  #  end

  # def hashtag_search()
  #   content.split(' ').each do |word|
  #     puts word
  #   end
  #   content[0]
  # end
  def create_hash_tags
    extract_content_hash_tags.each do |content|
    hash_tags.create(content: content)
    end
  end
    
  def extract_content_hash_tags
  description.to_s.scan(/#\w+/).map{|content| content.gsub("#", "")}
  end
end
