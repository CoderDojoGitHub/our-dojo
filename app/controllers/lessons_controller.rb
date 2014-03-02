class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end

  def show
    @show_registration = true
    @lesson = Lesson.find(params[:id])
  end
end
