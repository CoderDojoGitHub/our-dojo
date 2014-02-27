require "minitest_helper"

describe Event do
  describe "subscribers_to_notfiy" do
    it "only returns event_subscribers where sent_at is nil" do
      event = Event.make!
      subscriber1 = EventSubscriber.make!(event: event, sent_at: Time.now)
      subscriber2 = EventSubscriber.make!(event: event)

      assert_equal [subscriber2], event.subscribers_to_notify
    end
  end

  describe "#end_time" do
    it "defaults to DefaultEventLengthInHours after start_time" do
      start_time = Time.now
      assert_equal start_time + Event::DefaultEventLengthInHours.hours, Event.new(start_time: start_time).end_time
    end

    it "returns nil when when start_time and end_time are nil" do
      assert_nil Event.new.end_time
    end

    it "returns end_time if end_time is set" do
      end_time = 10.hours.ago

      assert_equal end_time, Event.new(:end_time => end_time).end_time
    end
  end

  describe "#class_size" do
    it "uses default class size if class_size is nil" do
      assert_equal Event::DefaultClassSize, Event.new.class_size
    end

    it "uses class_size when set" do
      assert_equal 30, Event.new(:class_size => 30).class_size
    end
  end

  describe "#upcoming" do
    it "returns nil if there is no upcoming event" do
      assert_nil Event.upcoming
    end

    it "returns upcoming event if it exists" do
      Event.make!(start_time: 3.days.from_now)
      event = Event.make!(start_time: 1.days.from_now)
      Event.make!(start_time: 2.day.from_now)

      assert_equal event, Event.upcoming
    end
  end

  describe "#open_for_registration?" do
    it "returns false if event completed" do
      refute Event.make(start_time: 4.days.ago).open_for_registration?
    end

    it "returns false unless event registration has passed" do
      refute Event.make(start_time: 8.days.from_now).open_for_registration?
    end

    it "returns false unless event has space available" do
      registration = Registration.make!(number_of_students: 20)
      refute registration.event.open_for_registration?
    end

    it "returns true" do
      assert Event.make(start_time: 4.days.from_now).open_for_registration?
    end
  end

  describe "#completed?" do
    it "returns false for future event" do
      refute Event.make(start_time: 1.day.from_now).completed?
    end

    it "returns true for past event" do
      assert Event.make(start_time: 1.day.ago).completed?
    end
  end

  describe "#registration_date_passed?" do
    it "returns false for event 8 days in the future" do
      refute Event.make(start_time: 8.day.from_now).registration_date_passed?
    end

    it "returns true for event 6 days in the future" do
      assert Event.make(start_time: 6.day.from_now).registration_date_passed?
    end
  end

  describe "#registration_date_still_in_the_future?" do
    it "returns false if class has room" do
      event = Event.make!
      event.stubs(:registration_date_passed? => true)

      refute event.registration_date_still_in_the_future?
    end

    it "returns true if class is full" do
      event = Event.make!
      event.stubs(:registration_date_passed? => false)

      assert event.registration_date_still_in_the_future?
    end
  end

  describe "#space_available?" do
    it "returns false if class is full" do
      event = Event.make!

      4.times do
        Registration.make!(event: event, number_of_students: 5)
      end

      refute event.space_available?
    end

    it "returns true if class has space available" do
      event = Event.make!

      3.times do
        Registration.make!(event: event, number_of_students: 5)
      end

      assert event.space_available?
    end
  end
end
