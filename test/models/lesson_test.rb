require "minitest_helper"

describe Lesson do
  it "must be valid" do
    assert Lesson.make.valid?
    refute Lesson.make(title: nil).valid?
    refute Lesson.make(title: "").valid?
    refute Lesson.make(repository: nil).valid?
    refute Lesson.make(repository: "").valid?
  end
end
