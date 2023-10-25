class Comment < ApplicationRecord
    
    belongs_to :user
    belongs_to :post
    
    def self.looks(search, word)
    if search == "perfect_match"
      @comment = Comment.where("name LIKE?", "#{word}")
    elsif search == "partial_match"
      @comment = Comment.where("name LIKE?", "%#{word}%")
    else
      @comment = Comment.all
    end
  end  
    
end
