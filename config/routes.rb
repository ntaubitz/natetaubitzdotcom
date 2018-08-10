Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'pages#overview'
  get '/contact' => 'pages#contact'
  post '/contact' => 'pages#contact_me'
  get '/code' => 'pages#code'
  get '/login' => 'pages#login'
  post '/login' => 'pages#authenticate'
  get '/logout' => 'pages#logout'
  get '/dashboard' => 'dashboard#index'
  post '/dashboard/create_short_post' => 'dashboard#create_short_post'

  resources :short_posts
end
