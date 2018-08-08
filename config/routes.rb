Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'pages#overview'
  get '/contact' => 'pages#contact'
  post '/contact' => 'pages#contact_me'
  get '/code' => 'pages#code'
  get '/react' => 'pages#react'

  resources :short_posts
end
