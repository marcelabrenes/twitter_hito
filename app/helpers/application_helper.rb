module ApplicationHelper
    def hashtag_trans(content)
        words = content.split(' ')
    new_content = words.map do |word|
      if word.include?('#')
        hash = word.split('#').last
        link_to word, tweets_path(q: hash)
      else
        word
      end
    end
    new_content.join(' ').html_safe
    end
end
