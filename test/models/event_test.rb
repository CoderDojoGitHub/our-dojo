require "minitest_helper"

describe Event do
  describe "#end_time" do
    it "defaults to DefaultEventLengthInHours after start_time" do
      start_time = Time.now
      assert_equal start_time + Event::DefaultEventLengthInHours.hours, Event.new(start_time: start_time).end_time
    end
  end
end
