require "minitest_helper"

describe Lesson do
  before do
    @lesson = Lesson.new
  end

  it "must be valid" do
    @lesson.valid?.must_equal true
  end
end
