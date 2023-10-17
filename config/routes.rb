Rails.application.routes.draw do
  
  #エンドユーザーサインアップ・サインイン
  devise_for :users, skip: [:passwords], controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  #ゲストユーザーログイン
  devise_scope :user do
    post 'users_guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  
  #アドミンユーザーサインイン
  devise_for :admins, skip: [:registrations, :passwords] ,controllers:{
    sessions: "admin/sessions"
  }
  
  #エンドユーザー用
  scope module: :public do
    root to: 'homes#top'
    
    resources :users, only: [:index, :show, :edit, :update]
    
    resources :posts, only: [:new, :index, :show, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
    end
    
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
