require "minitest_helper"

describe Registrar do
  describe ".register" do
    it "creates Registrant and TemporaryRegistration" do
      event = Event.make!

      assert_equal 0, Registrant.count
      assert_equal 0, TemporaryRegistration.count
      temporary_registration = Registrar.register(event, "foo@bar.com", 2)
      assert_equal 1, Registrant.count
      assert_equal 1, TemporaryRegistration.count
      assert temporary_registration.is_a?(TemporaryRegistration)
    end

    it "does not duplicate registrant" do
      event = Event.make!
      Registrant.make!(email: "jonmagic@gmail.com")

      assert_equal 1, Registrant.count
      Registrar.register(event, "jonmagic@gmail.com", 2)
      assert_equal 1, Registrant.count
    end

    it "does not duplicate temporary registration" do
      event = Event.make!
      registrant = Registrant.make!
      TemporaryRegistration.make!(event: event, registrant: registrant)

      assert_equal 1, TemporaryRegistration.count
      Registrar.register(event, registrant.email, 2)
      assert_equal 1, TemporaryRegistration.count
    end
  end

  describe ".confirm_registration" do
    it "creates registration" do
      temporary_registration = TemporaryRegistration.make!

      assert_equal 0, Registration.count
      registration = Registrar.confirm_registration(temporary_registration)
      assert_equal 1, Registration.count
      assert registration.is_a?(Registration)
    end

    it "removes temporary registration" do
    end
  end
end
