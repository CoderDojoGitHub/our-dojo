require "minitest_helper"

class HomeIndexTest < AcceptanceTest
  it "renders the homepage" do
    visit "/"
    must_have_content "CoderDojo - San Francisco"
    must_have_content "View all lessons"
  end
end
