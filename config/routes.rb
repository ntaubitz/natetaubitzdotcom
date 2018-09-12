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
  get '/vue' => 'pages#vue'
  get '/reports' => 'reports#index'
  get '/settings' => 'settings#index'
  get '/logout' => 'pages#logout'

  # Settings
  post '/settings/change_password' => 'settings#change_password'

  # Short Posts
  resources :short_posts
  post '/dashboard/create_short_post' => 'dashboard#create_short_post'

  # Work Logs
  resources :work_logs
  get '/dashboard/start_work_log' => 'dashboard#start_work_log'
  get '/dashboard/finish_work_log' => 'dashboard#finish_work_log'
  post '/dashboard/save_work_log' => 'dashboard#save_work_log'

  # Blog Posts
  get '/dashboard/create_blog_post' => 'dashboard#create_blog_post'
  post '/dashboard/save_blog_post' => 'dashboard#save_blog_post'
end
