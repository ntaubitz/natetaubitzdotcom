Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # Pages
  get '/' => 'pages#overview'
  get '/contact' => 'pages#contact'
  post '/contact' => 'pages#contact_me'
  get '/code' => 'pages#code'
  get '/login' => 'pages#login'
  post '/login' => 'pages#authenticate'
  get '/dashboard' => 'dashboard#index'
  get '/blog' => 'pages#blog'


  post '/dashboard/create_short_post' => 'dashboard#create_short_post'
  get '/dashboard/create_blog_post' => 'dashboard#create_blog_post'
  post '/dashboard/save_blog_post' => 'dashboard#save_blog_post'
  get '/logout' => 'pages#logout'

  resources :short_posts
end
