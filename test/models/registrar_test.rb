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
      assert_equal TemporaryRegistration, temporary_registration.class
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
      assert_equal Registration, registration.class
    end

    it "removes temporary registration" do
      temporary_registration = TemporaryRegistration.make!
      Registrar.confirm_registration(temporary_registration)

      assert_raises(ActiveRecord::RecordNotFound) { temporary_registration.reload }
    end

    it "returns early if class is full" do
      temporary_registration = TemporaryRegistration.make!
      event = temporary_registration.event
      event.stubs(:space_available? => false)
      assert_nil Registrar.confirm_registration(temporary_registration)
      assert temporary_registration.persisted?
    end
  end
end
