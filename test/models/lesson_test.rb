require "minitest_helper"

describe Lesson do
  it "must be valid" do
    assert Lesson.make.valid?
    refute Lesson.make(title: nil).valid?
    refute Lesson.make(title: "").valid?
    refute Lesson.make(repository: nil).valid?
    refute Lesson.make(repository: "").valid?
  end

  describe "#events" do
    it "returns hash of events" do
      events_attributes = [{foo: "bar"}]
      assert_equal events_attributes, Lesson.new(events_attributes: events_attributes).events_attributes
    end
  end

  describe "#upcoming_event" do
    it "returns nil if there is no upcoming event" do
      lesson = Lesson.make!(events_attributes: nil)

      assert_nil lesson.upcoming_event
    end

    it "returns upcoming event if it exists" do
      lesson = Lesson.make!
      Event.make!(lesson: lesson, start_time: 3.days.from_now)
      event = Event.make!(lesson: lesson, start_time: 1.days.from_now)
      Event.make!(lesson: lesson, start_time: 2.day.from_now)

      assert_equal event, lesson.upcoming_event
    end
  end

  describe "#most_recent" do
    it "returns most recent lesson" do
      Lesson.make!(created_at: 3.days.ago)
      lesson = Lesson.make!(created_at: 1.days.ago)
      Lesson.make!(created_at: 2.days.ago)

      assert_equal lesson, Lesson.most_recent
    end
  end
end
