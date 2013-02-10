class SessionsController < ApplicationController
  skip_before_filter :authenticate_user!

  def create
    @user = User.find_for_github_oauth(request.env["omniauth.auth"])

    if @user && @user.persisted?
      sign_in_and_redirect @user
    else
      redirect_to "/auth/failure"
    end
  end

  def failure
    render :text => "Auth Failed"
  end

  def logout
    reset_session
    redirect_to "https://github.com"
  end
end