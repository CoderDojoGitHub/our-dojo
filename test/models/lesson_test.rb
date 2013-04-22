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
end
