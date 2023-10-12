class Public::PostsController < ApplicationController
    
    def index
        @new_post = Post.new
        
        
    end
    
    def show
        @new_post = Post.new
    end
    
    def create
        @new_post = Post.new(post_params)
        @new_post.user_id = current_user.id
        @new_post.save
        redirect_to posts_path
   end
   
   private
   
   def post_params
       params.require(:post).permit(:images, :text)
   end
       
end
