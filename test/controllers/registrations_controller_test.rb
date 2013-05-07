require "minitest_helper"

describe RegistrationsController do
  setup do
    ActionMailer::Base.deliveries.clear
  end

  describe "POST to #register" do
    describe "on success" do
      def post_to_register
        @event = Event.make!
        post :register,
             {id: @event.id, email: "foo@bar.com", number_of_students: 1}
      end

      it "creates Registrant" do
        assert_equal 0, Registrant.count
        post_to_register
        assert_equal 1, Registrant.count
      end

      it "creates TemporaryRegistration" do
        assert_equal 0, TemporaryRegistration.count
        post_to_register
        assert_equal 1, TemporaryRegistration.count
      end

      it "delivers RegistrationMailer#confirm email" do
        assert_equal 0, ActionMailer::Base.deliveries.length
        post_to_register
        assert_equal 1, ActionMailer::Base.deliveries.length
      end

      it "redirects to lesson and flashes notice" do
        post_to_register
        assert_equal 302, response.status
        assert_equal "http://test.host/lessons/#{@event.id}", response.headers["Location"]
        assert_equal "Please check your email to confirm your registration.",
                     session["flash"][:notice]
      end
    end

    describe "on failure" do
      it "redirects to lesson and flashes error on failure" do
        event = Event.make!
        post :register,
             {id: event.id, number_of_students: 1}

        assert_equal 302, response.status
        assert_equal "http://test.host/lessons/#{event.id}", response.headers["Location"]
        assert_equal "Registration failed.", session["flash"][:error]
      end
    end
  end

  describe "GET to #confirm" do
    def get_to_confirm
      temporary_registration = TemporaryRegistration.make!
      @event = temporary_registration.event
      get :confirm, id: temporary_registration.reference_token
    end

    describe "on success" do
      it "creates Registration" do
        assert_equal 0, Registration.count
        get_to_confirm
        assert_equal 1, Registration.count
      end

      it "delivers RegistrationMailer#confirmed email" do
        assert_equal 0, ActionMailer::Base.deliveries.length
        get_to_confirm
        assert_equal 1, ActionMailer::Base.deliveries.length
      end

      it "redirects to lesson and flashes notice" do
        get_to_confirm
        assert_equal 302, response.status
        assert_equal "http://test.host/lessons/#{@event.id}", response.headers["Location"]
        assert_equal "You registration is confirmed!",
                     session["flash"][:notice]
      end
    end

    describe "on failure" do
      it "redirects to lesson and flashes error on failure" do
        Registrar.stubs(:confirm_registration => nil)
        get_to_confirm

        assert_equal 302, response.status
        assert_equal "http://test.host/lessons/#{@event.id}", response.headers["Location"]
        assert_equal "We were unable to register you for this class.",
                     session["flash"][:error]
      end
    end
  end
end
