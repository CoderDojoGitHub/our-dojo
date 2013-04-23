class HomeController < ApplicationController
  def index
    @lesson = if event = Event.upcoming
      event.lesson
    else
      Lesson.most_recent
    end
  end
end