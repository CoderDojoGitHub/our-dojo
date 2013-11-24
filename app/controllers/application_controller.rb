require 'mailchimp'

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :setup_mcapi

  # Public: The signed in user. This is available in views and helpers.
  #
  # Returns a User.
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  helper_method :current_user

  # Public: Is the visitor signed in?
  #
  # Returns a TrueClass or FalseClass.
  def signed_in?
    !!current_user
  end

  # Public: Set current_user equal to user and redirect to url in session
  # or to the root path.
  #
  # user - User instance.
  def sign_in_and_redirect(user)
    self.current_user = user
    redirect_to session[:user_return_to] || root_path
  end

  # Internal: Sets @current_user to user and user_id in session.
  #
  # user - User instance.
  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  # Require that the user is signed in to view
  # the current action.
  #
  # Redirects to login if the user is not signed in.
  def authenticate_user!
    if !signed_in?
      session[:user_return_to] = request.path if request.path
      redirect_to "/auth/githubteammember"
    end
  end

  private 

  # Internal: Creates a new instance of the Mailchimp API
  def setup_mcapi
    @mc = Mailchimp::API.new(ENV["MAILCHIMP_API_KEY"])
  end
end
