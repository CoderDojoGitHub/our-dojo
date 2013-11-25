CoderdojoWebapp::Application.routes.draw do
  # Authentication routes.
  match "/auth/githubteammember/callback"   => "sessions#create"
  match "/logout"                           => "sessions#logout"
  match "/auth/failure"                     => "sessions#failure"

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

  # Admin routes.
  get "/admin", to: "admin/lesson_builder#index"

  # Default routes.
  root to: "home#index"
end
