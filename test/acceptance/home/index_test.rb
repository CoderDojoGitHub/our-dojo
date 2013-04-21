require "minitest_helper"

class HomeIndexTest < AcceptanceTest
  it "renders the homepage" do
    visit "/"
    must_have_content "CoderDojo - San Francisco"
    must_have_content "Upcoming Event"
    must_have_content "Upcoming Events Newsletter"
  end
end
