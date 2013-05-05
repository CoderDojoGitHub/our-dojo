require "minitest_helper"

class LessonsIndexTest < AcceptanceTest
  it "renders lesson" do
    lesson = Lesson.make!(title: "Data Types")

    visit "/lessons/#{lesson.id}"

    must_have_content "CoderDojo - San Francisco"
    must_have_content "Data Types"
  end

  describe "before registration has opened" do
    describe "Notify me when registration opens" do
      it "subscribes to event and flashes message" do
        DatabaseCleaner.clean_with :deletion
        event = Event.make!(start_time: 8.days.from_now)

        assert_equal 0, EventSubscriber.count
        visit "/lessons/#{event.lesson.id}"

        must_have_content "Notify me when registration opens"
        fill_in :email, with: "jonmagic@gmail.com"
        click_button "Notify me"

        must_have_content "You will receive an email when registration opens for this event."
        assert_equal 1, EventSubscriber.count
      end
    end
  end

  describe "after registration date has past" do
    describe "class has space available" do
      describe "on success" do
        it "creates temporary registration and flashes message" do
          DatabaseCleaner.clean_with :deletion
          event = Event.make!

          assert_equal 0, TemporaryRegistration.count
          visit "/lessons/#{event.lesson.id}"

          must_have_content "Register for event"
          fill_in :email, with: "jonmagic@gmail.com"
          click_button "Register"

          must_have_content "Please check your email to confirm your registration."
          assert_equal 1, TemporaryRegistration.count
        end
      end
    end

    describe "class is full" do
      it "renders class is full message" do
        event = Event.make!
        Registration.make!(event: event, number_of_students: 20)

        visit "/lessons/#{event.lesson.id}"
        must_have_content "Registration has closed"
        must_have_content "The class is full."
      end
    end
  end
end
