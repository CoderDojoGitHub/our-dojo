class HomeController < ApplicationController
  def index
    @page_class = "home"
    @upcoming_events = Event.upcoming(2)
    @list_id = ENV["MAILCHIMP_LIST_ID"]
  end
end
