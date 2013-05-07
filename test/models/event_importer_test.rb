require "minitest_helper"

describe EventImporter do
  describe "#import" do
    it "creates events from lesson events array" do
      lessons = [Lesson.make!]
      importer = EventImporter.new(lessons)

      assert_equal 0, Event.count
      events = importer.import
      assert events.present?
      assert_equal 1, Event.count

      event = Event.first
      date = 1.week.from_now
      assert_equal date.month, event.start_time.month
      assert_equal date.day, event.start_time.day
      assert_equal date.year, event.start_time.year
      assert_equal date.hour, event.start_time.hour
      assert_equal date.min, event.start_time.min
    end

    it "handles lessons without events" do
      lessons = [Lesson.make, Lesson.make(events_attributes: nil)]
      importer = EventImporter.new(lessons)
      assert 1, importer.import.length
    end
  end
end