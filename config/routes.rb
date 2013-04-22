CoderdojoWebapp::Application.routes.draw do
  match "/auth/githubteammember/callback" => "sessions#create"
  match "/logout"                           => "sessions#logout"
  match "/auth/failure"                     => "sessions#failure"

  resources :lessons, only: [:index]

  root to: "home#index"
end
