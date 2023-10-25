class Post < ApplicationRecord
    
    has_many_attached :images
    
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :favorites, dependent: :destroy
    
    def get_images
        unless images.attached?
            file_path = Rails.root.join('app/assets/images/no_image.jpg')
            images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
           images
    end
    
    def favorited_by?(user)
        favorites.exists?(user_id: user.id)
    end  
    
    def self.looks(search, word)
        if search == "perfect_match"
          @post = Post.where("text LIKE?", "#{word}")
        elsif search == "partial_match"
          @post = Post.where("text LIKE?", "%#{word}%")
        else
          @post = Post.all
        end
    end  
    
    
    validates :text, presence: true
    
end
