Rails.application.routes.draw do
  root 'home#top'
  get 'home/about' =>'home#about'
  get '/search', to: 'search#search'

  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
  resource :relationships,only: [:create,:destroy]
     member do
      get 'follow'
      get 'follower'
    end
  end
  resources :books do
	  resource  :favorites, only: [:create, :destroy]
	   resource :book_comments, only: [:create, :destroy]
	   # resources :book_comments, only: [:create, :destroy]
	end
end
