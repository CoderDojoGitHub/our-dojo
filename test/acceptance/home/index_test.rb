require "minitest_helper"

class HomeIndexTest < AcceptanceTest
  it "renders the homepage" do
    event = Event.make!

    visit "/"

    must_have_content "CoderDojo San Francisco"
    must_have_content "View all lessons"
    must_have_content event.lesson.title
    must_have_content event.lesson.summary
  end
end
