class HomeController < ApplicationController
  def index
    @lesson = Lesson.first
  end
end