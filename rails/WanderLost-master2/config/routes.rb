Rails.application.routes.draw do

  resources :products
  resources :categories
  devise_for :users

  resources :blog_posts

  resources :users, only: [:show, :index,:messages] do
    member do
      put :messages
    end
  end

  resources :friendships, only: [:create, :destroy, :accept] do
  	member do 
  		put :accept
  	end
  end
  resources :messages,only:[:create,:show,:destroy]

  resources :comments, only: [:edit, :create, :udpate, :destroy]

  resources :posts, only: [:create, :update, :edit, :destroy]

  resources :activities, only: [:index]

  root 'welcome#index'

  get 'your_posts' => 'blog_posts#your_posts'

  get 'user_profile' => 'blog_posts#user_profile'

  get 'user_messages'=>'users#messages'

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
