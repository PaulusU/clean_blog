Rails.application.routes.draw do
  get 'sessions/new'
  get 'blog_post/new'
  get 'users/new'
  root "static_pages#home"
  get '/about', to:'static_pages#about'
  get '/blog_post', to:'static_pages#blog'
  get '/signup', to: 'users#new'
  get '/users', to: 'users#users'
  get '/upload_blog', to: 'blog_posts#upload'
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  get '/recent_search', to: 'static_pages#recent_search'
  delete "/logout",  to: "sessions#destroy" 
  delete 'blog_post/:id', to: 'blog_posts#destroy', as: :delete_blog_post
  get 'blog_post/:id', to: 'blog_posts#show', as: :show_blog_post
  patch 'blog_post', to: 'blog_posts#update', as: :update_blog_post
  
  resources :users
  get 'blog_posts/new', to: 'blog_posts#new'
  resources :blog_posts, only: [:create, :destroy, :show, :edit, :update], except: [:update]

end
