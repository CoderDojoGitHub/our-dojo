require "minitest_helper"

describe EventSubscriber do
  it "must be valid" do
    assert EventSubscriber.make.valid?
    refute EventSubscriber.make(email: nil).valid?
    refute EventSubscriber.make(event: nil).valid?
  end
end
