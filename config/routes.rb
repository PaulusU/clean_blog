Rails.application.routes.draw do
  get 'sessions/new'
  get 'blog_post/new'
  get 'users/new'
  root "static_pages#home"
  get '/about', to:'static_pages#about'
  get '/blog_post', to:'static_pages#blog'
  get '/signup', to: 'users#new'
  get '/users', to: 'users#users'
  get '/upload_blog', to: 'blog_post#upload'
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  
  resources :users
  resources :blog_posts, only: [:create, :destroy]

end
