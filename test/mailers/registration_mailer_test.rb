require "minitest_helper"

describe RegistrationMailer do
  describe "#open" do
    it "contains event and lesson info" do
      event_subscriber = EventSubscriber.make!
      event = event_subscriber.event
      lesson = event.lesson
      mail = RegistrationMailer.open(event.id, event_subscriber.id)

      assert_equal "[CoderDojo - San Francisco] Event registration is open", mail.subject
      assert_equal [event_subscriber.email], mail.to
      assert_equal [ENV["REPLY_TO_EMAIL"]], mail.from

      body = mail.body.encoded

      assert_not_nil body =~ /#{event.start_time.strftime("%A, %B %-d")}/
      assert_not_nil body =~ /#{lesson.title}/
      assert_not_nil body =~ /#{lesson.summary}/
      assert_not_nil body =~ /#{event.start_time.strftime("%l:%M%p")}/
      assert_not_nil body =~ /#{event.end_time.strftime("%l:%M%p")}/
      assert_not_nil body =~ /http:\/\/example.com\/lessons\/#{lesson.id}/
    end
  end

  describe "#confirm" do
    it "contains instructions to confirm" do
      temporary_registration = TemporaryRegistration.make!
      event = temporary_registration.event
      mail = RegistrationMailer.confirm(temporary_registration.id)

      assert_equal "[CoderDojo - San Francisco] Please confirm your registration.", mail.subject
      assert_equal [temporary_registration.registrant.email], mail.to
      assert_equal [ENV["REPLY_TO_EMAIL"]], mail.from

      body = mail.body.encoded

      assert_not_nil body =~ /#{event.start_time.strftime("%A, %B %-d")}/
      assert_not_nil body =~ /#{event.start_time.strftime("%l:%M%p")}/
      assert_not_nil body =~ /http:\/\/example.com\/confirm\/#{temporary_registration.reference_token}/
    end
  end

  describe "#confirmed" do
    it "contains confirmation info" do
      registration = Registration.make!
      event = registration.event
      lesson = event.lesson
      mail = RegistrationMailer.confirmed(registration.id)

      assert_equal "[CoderDojo - San Francisco] Your reservation is confirmed!", mail.subject
      assert_equal [registration.registrant.email], mail.to
      assert_equal [ENV["REPLY_TO_EMAIL"]], mail.from

      body = mail.body.encoded

      assert_not_nil body =~ /#{event.start_time.strftime("%A, %B %-d")}/
      assert_not_nil body =~ /#{event.start_time.strftime("%l:%M%p")}/
      assert_not_nil body =~ /#{event.location}/
      assert_not_nil body =~ /http:\/\/example.com\/lessons\/#{lesson.id}/
    end
  end
end
