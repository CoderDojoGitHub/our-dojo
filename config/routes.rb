CoderdojoWebapp::Application.routes.draw do

  # Active admin sets up its own routes.
  ActiveAdmin.routes(self)

  # Authentication routes.
  match "/auth/githubteammember/callback", to: "sessions#create", via: :all
  match "/logout", to: "sessions#logout", via: :all
  match "/auth/failure", to: "sessions#failure", via: :all

  # Resource routes.
  resources :lessons, only: [:index, :show]

  # Subscription and Registration routes.
  post "/subscribe/:id",  to: "subscriptions#event",    as: :subscribe_to_event
  post "/register/:id",   to: "registrations#register", as: :register
  get  "/confirm/:id",    to: "registrations#confirm",  as: :confirm

  # Mailing List routes
  post "/newsletters/announcements", to: "newsletters#announcements"

  # Preview emails routes.
  if Rails.env.development?
    mount MailPreview => "mail_view"
  end

  # Default routes.
  root to: "home#index"
end
