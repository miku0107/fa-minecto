class Public::UsersController < ApplicationController
    
    def index
    end
    
    def show
        @new_post = Post.new
        @user = User.find(params[:id])
        @posts = @user.posts
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def withdraw
        @user = User.find(current_user.id)
        @user.update(is_active: false)
        reset_session
        flash[:notice] = "退会処理を実行しました"
        redirect_to root_path
    end
    
    def update
        @user = User.find(params[:id])
        
        if @user.update(user_params)
           redirect_to user_path(@user)
        else
           render "edit"
        end
    end
    
    private
    
    def user_params
        params.require(:user).permit(:name, :bio, :location, :birth_date)
    end    
end
