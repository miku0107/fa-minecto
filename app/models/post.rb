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
    
    
    validates :text, presence: true
    
end
