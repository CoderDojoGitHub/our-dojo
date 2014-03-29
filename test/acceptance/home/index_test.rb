require "minitest_helper"

class HomeIndexTest < AcceptanceTest
  it "renders the homepage" do
    events = [Event.make!]

    visit "/"

    must_have_content "CoderDojo San Francisco"
    must_have_content "View all lessons"
    must_have_content events.first.lesson.title
    must_have_content events.first.lesson.summary
  end
  
  it "pluralizes the 'Upcoming Event' heading when appropriate" do
    events = [Event.make!]
    visit "/"
    must_have_content "Upcoming Event"
    
    events.push(Event.make!)
    visit "/"
    must_have_content "Upcoming Events"
  end

  it "renders up to two upcoming events" do
    events = [Event.make!, Event.make!, Event.make!]
    
    visit "/"
    
    must_have_content events[0].lesson.title
    must_have_content events[1].lesson.title
    wont_have_content events[2].lesson.title
  end
end
