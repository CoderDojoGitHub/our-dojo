require "minitest_helper"

class LessonsIndexTest < AcceptanceTest
  it "renders list of lessons" do
    lesson = Lesson.make!(title: "Data Types")

    visit "/lessons/#{lesson.id}"

    must_have_content "CoderDojo - San Francisco"
    must_have_content "Data Types"
  end

  describe "Register for event" do
    describe "on success" do
      it "flashes Please check your email to confirm your registration" do
        lesson = Lesson.make!(title: "Data Types")
        Event.make!(lesson: lesson)

        visit "/lessons/#{lesson.id}"
        fill_in :email, with: "jonmagic@gmail.com"
        click_button "Register"

        must_have_content "Please check your email to confirm your registration."
      end
    end
  end
end