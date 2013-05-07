require "minitest_helper"

class LessonsIndexTest < AcceptanceTest
  def setup
    Lesson.make!(title: "Data Types")
    Lesson.make!(title: "First Program")
  end

  it "renders list of lessons" do
    visit "/lessons"

    must_have_content "CoderDojo - San Francisco"
    must_have_content "Data Types"
    must_have_content "First Program"
  end
end