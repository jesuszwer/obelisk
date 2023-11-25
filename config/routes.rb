Rails.application.routes.draw do

  root to: "welcome#index"

  #! Clearance routes start
  # Routes for gem Clearance which is responsible for user authentication

  # Routes for password reset
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]

  # Routes for sessions
  resource :session, controller: "clearance/sessions", only: [:create]

  # Routes for users registration
  resources :users, controller: "users", only: [:create] do
    # Routes for password edit
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  resources :users, only: [:index,:show,:edit, :update]

  # Routes for sign in and sign out
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # Session out routes
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"

  # Clearance routes end

  #! Blog routes
  resources :posts, only: [:index,:new,:create,:show], controller: "blog/posts" do
    resources :comments, only: [:index,:new, :create], controller: "blog/comments"
  end



end
