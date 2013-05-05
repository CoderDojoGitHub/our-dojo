CoderdojoWebapp::Application.routes.draw do
  match "/auth/githubteammember/callback" => "sessions#create"
  match "/logout"                           => "sessions#logout"
  match "/auth/failure"                     => "sessions#failure"

  resources :lessons, only: [:index, :show]

  post "/subscribe/:id",  to: "subscriptions#event",    as: :subscribe_to_event
  post "/register/:id",   to: "registrations#register", as: :register
  get  "/confirm/:id",    to: "registrations#confirm",  as: :confirm

  if Rails.env.development?
    mount MailPreview => "mail_view"
  end

  root to: "home#index"
end
