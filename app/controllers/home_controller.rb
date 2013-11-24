class HomeController < ApplicationController
  def index
    @lesson = if event = Event.upcoming
      event.lesson
    else
      Lesson.most_recent
    end
    @list_id = ENV["MAILCHIMP_LIST_ID"]
  end

  def subscribe
    list_id = params['list_id']
    email = params['email']
    begin
      @mc.lists.subscribe(list_id, {'email' => email})
    rescue Mailchimp::ListAlreadySubscribedError
      render :text => "Looks like #{email} is already subscribed to the list!", status: 400
      return
    rescue Mailchimp::ListDoesNotExistError
      render :text => "We're having an issue adding your email. Try it again.", status: 400
      return
    rescue Mailchimp::Error => ex
      render :text => "We're having an issue adding your email. Try it again.", status: 400
    end
    render :json => { :email => email }
  end

end