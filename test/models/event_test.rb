require "minitest_helper"

describe Event do
  describe "#end_time" do
    it "defaults to DefaultEventLengthInHours after start_time" do
      start_time = Time.now
      assert_equal start_time + Event::DefaultEventLengthInHours.hours, Event.new(start_time: start_time).end_time
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
end
