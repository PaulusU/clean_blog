Rails.application.routes.draw do
  get 'blog_post/new'
  get 'users/new'
  root "static_pages#home"
  get '/about', to:'static_pages#about'
  get '/blog_post', to:'static_pages#blog'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
end
