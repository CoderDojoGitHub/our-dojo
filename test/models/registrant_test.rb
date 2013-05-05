require "minitest_helper"

describe Registrant do
  describe "#email" do
    it "must be a valid email" do
      registrant = Registrant.make
      assert registrant.valid?

      registrant.email = "foo"
      refute registrant.valid?
    end
  end
end
