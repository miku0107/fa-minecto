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
    
    
    get '/users/check' => 'users#check'
    patch '/users/withdraw' => 'users#withdraw'
    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get :follows, :followers
      end
      resource :relationships, only: [:create, :destroy]
    end
    
    
    resources :posts, only: [:new, :index, :show, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    
    get "search" => "searches#search"
    
  end
  
  namespace :admin do
    get '/' => 'posts#index'
  end  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
