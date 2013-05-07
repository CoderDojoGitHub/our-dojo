require "minitest_helper"

describe TemporaryRegistration do
  describe "before_create :set_reference_token" do
    it "sets the reference_token" do
      temporary_registration = TemporaryRegistration.make
      assert temporary_registration.reference_token.nil?
      assert temporary_registration.save
      assert temporary_registration.reference_token.present?
    end
  end
end
