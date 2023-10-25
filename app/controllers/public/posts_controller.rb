class Public::PostsController < ApplicationController
    
    def index
        @new_post = Post.new
        @posts = Post.all
        
    end
    
    def show
        @new_post = Post.new
        @post = Post.find(params[:id])
        @comment = Comment.new
    end
    
    def create
        @new_post = Post.new(post_params)
        @new_post.user_id = current_user.id
        if @new_post.save
           flash[:notice] = "投稿しました"
           redirect_to posts_path
        else
           render :index
        end   
    end
    
    def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to posts_path
    end
    
   private
   
   def post_params
       params.require(:post).permit(:images, :text, :user_id)
   end
       
end
