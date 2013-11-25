class NewslettersController < ApplicationController
  def announcements
    if error_message = EmailList.announcements.subscribe(params[:email])
      render :text => error_message, :status => :unprocessable_entity
    else
      render :json => { :email => params[:email] }
    end
  end
end
