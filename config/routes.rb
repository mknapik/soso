Soso3::Application.routes.draw do

  root to: 'pages#root'

  devise_for :users, :path => "auth", :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'cmon_let_me_in' }

  get 'sign_in' => 'user_sessions#new', as: :sign_in
  get 'sign_out' => 'user_sessions#destroy', as: :sign_out

  resources :user_sessions, only: [:new, :create, :destroy]

  get 'sign_up' => 'registrations#new', as: :sign_up
  post 'sign_up' => 'registrations#create', as: :sign_up
  get 'activate/:token' => 'registrations#activate', as: :activation

  get 'forgotten_password' => 'password_resets#new', as: :forgotten_password
  post 'forgotten_password' => 'password_resets#create', as: :forgotten_password
  get 'reset_password/:token' => 'password_resets#edit', as: :reset_password
  patch 'reset_password/:id' => 'password_resets#update'

  resources :users

end
