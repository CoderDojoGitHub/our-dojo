class HomeController < ApplicationController
  def index
    @lesson = if @event = Event.upcoming
      @event.lesson
    end
    @list_id = ENV["MAILCHIMP_LIST_ID"]
  end
end
