class NewslettersController < ApplicationController
  def announcements
    if error_message = EmailList.announcements.subscribe(params[:email])
      render :text => error_message, :status => 400
    else
      render :json => { :email => email }
    end
  end
end
