class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
  helper_method :current_user

  def signed_in?
    !!current_user
  end

  def sign_in_and_redirect(user)
    self.current_user = user
    redirect_to session[:user_return_to] || root_path
  end

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
end
