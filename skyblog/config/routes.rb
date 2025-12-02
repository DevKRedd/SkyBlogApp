Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  
  # Health check for ECS - simple inline response that bypasses middleware
  get "/up", to: proc { [200, {}, ["OK"]] }

  post "/signup", to: "users#create"
  post "/login",  to: "sessions#create"

  resources :blog_posts, only: [ :index, :show, :create, :update, :destroy ]


  # Defines the root path route ("/")
  # root "posts#index"
end
