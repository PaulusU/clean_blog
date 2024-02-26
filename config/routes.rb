Rails.application.routes.draw do
  get 'sessions/new'
  get 'blog_post/new'
  get 'users/new'
  root "static_pages#home"
  get '/about', to:'static_pages#about'
  get '/blog_post', to:'static_pages#blog'
  get '/signup', to:'users#new'
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
end
