class HomeController < ApplicationController
  def index
    @lesson = if event = Event.upcoming
      event.lesson
    else
      Lesson.most_recent
    end
    @list_id = ENV["MAILCHIMP_LIST_ID"]
  end
end
