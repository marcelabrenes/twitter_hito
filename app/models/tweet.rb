class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :retweets, class_name: "Tweet", foreign_key: "retweet_id"
  belongs_to :retweet, class_name: "Tweet", optional: true
  validates :content, presence: true

  def hashtag
    words = content.split(' ')
    new_content = words.map do |word|
      if word.include?('#')
        hash = word.split('#').last
        "<a href='/tweets?q=#{hash}'>#{word}</a>"
      else
        word
      end
    end
    new_content.join(' ').html_safe
  end
end
