class HomeController < ApplicationController
  def index
    @page_class = "home"
    @lesson = if @event = Event.upcoming
      @event.lesson
    end
    @list_id = ENV["MAILCHIMP_LIST_ID"]
  end
end
