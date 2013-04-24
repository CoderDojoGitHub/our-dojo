CoderdojoWebapp::Application.routes.draw do
  match "/auth/githubteammember/callback" => "sessions#create"
  match "/logout"                           => "sessions#logout"
  match "/auth/failure"                     => "sessions#failure"

  resources :lessons, only: [:index, :show]

  post "/register/:id", to: "registrations#register", as: :register
  get  "/confirm/:id",  to: "registrations#confirm",  as: :confirm

  root to: "home#index"
end
