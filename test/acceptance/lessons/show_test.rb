require "minitest_helper"

class LessonsIndexTest < AcceptanceTest
  it "renders list of lessons" do
    lesson = Lesson.make!(title: "Data Types")

    visit "/lessons/#{lesson.id}"

    must_have_content "CoderDojo - San Francisco"
    must_have_content "Data Types"
  end
end