# Mailer used to notify an EventSubscriber that registration has opened
# for an Event and also notify a Registrant that their Registration has
# been confirmed for an Event.
class RegistrationMailer < ActionMailer::Base
  default from: ENV["REPLY_TO_EMAIL"]

  # Public: Open registration notification email.
  #
  # event_id - Id of the Event.
  # event_subscriber_id - Id of the EventSubscriber.
  #
  # Returns a Mail::Message.
  def open(event_id, event_subscriber_id)
    @event = Event.find(event_id)
    event_subscriber = EventSubscriber.find(event_subscriber_id)

    mail subject: "[CoderDojo - San Francisco] Event registration is open",
         to: event_subscriber.email
  end

  # Public: Confirm registration email.
  #
  # event_id - Id of the Event.
  # registration_id - Id of the Registration.
  #
  # Returns a Mail::Message.
  def confirm(temporary_registration_id)
    @temporary_registration = TemporaryRegistration.find(temporary_registration_id)
    @event = @temporary_registration.event

    mail subject: "[CoderDojo - San Francisco] Please confirm your registration.",
         to: @temporary_registration.registrant.email
  end

  # Public: Registration confirmed email.
  #
  # event_id - Id of the Event.
  # registration_id - Id of the Registration.
  #
  # Returns a Mail::Message.
  def confirmed(registration_id)
    registration = Registration.find(registration_id)
    @event = registration.event

    mail subject: "[CoderDojo - San Francisco] Your reservation is confirmed!",
         to: registration.registrant.email
  end
end
