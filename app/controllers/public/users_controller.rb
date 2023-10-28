class Public::UsersController < ApplicationController
    before_action :ensure_current_user, only: [:edit, :update]
    
    def index
    end
    
    def show
        @new_post = Post.new
        @user = User.find(params[:id])
        @posts = @user.posts
        @following_users = @user.following_users
        @follower_users = @user.follower_users
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def withdraw
        @user = User.find(current_user.id)
        
        if @user.email == 'guest@test.com'
            redirect_to user_path(current_user)
            flash[:notice] = "ゲストユーザーは退会できません"
        else    
            @user.update(is_active: false)
            reset_session
            flash[:notice] = "退会処理を実行しました"
            redirect_to root_path
        end
    end
    
    def update
        @user = User.find(params[:id])
        
        if @user.update(user_params)
           redirect_to user_path(@user)
        else
           render "edit"
        end
    end
    
    # フォロー一覧
    def follows
      user = User.find(params[:id])
      @users = user.following_users
    end
    
    # フォロワー一覧
    def followers
      user = User.find(params[:id])
      @user = user.follower_users
    end

    
    private
    
    def user_params
        params.require(:user).permit(:name, :bio, :location, :birth_date)
    end 
    
    def ensure_current_user
        @user = User.find(params[:id])
        unless @user == current_user
            redirect_to user_path(current_user)
        end    
    end
  
end
