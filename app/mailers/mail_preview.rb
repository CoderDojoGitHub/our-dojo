require Rails.root.join("test", "blueprints") if Rails.env.development?

class MailPreview < MailView

  # Public: Renders RegistrationMailer#open in the browser.
  def registration_open
    mail = RegistrationMailer.open(event.id, event_subscriber.id)
    destroy_fixtures
    mail
  end

  # Public: Renders RegistrationMailer#confirm in hte browser
  def registration_confirm
    mail = RegistrationMailer.confirm(temporary_registration)
    destroy_fixtures
    mail
  end

  # Public: Renders RegistrationMailer#confirmed in the browser.
  def registration_confirmed
    mail = RegistrationMailer.confirmed(registration.id)
    destroy_fixtures
    mail
  end

  # Internal: Lesson from a blueprint.
  #
  # Returns a Lesson.
  def lesson
    @lesson ||= Lesson.make!
  end

  # Internal: Event from a blueprint.
  #
  # Returns an Event.
  def event
    @event ||= Event.make!(lesson: lesson)
  end

  # Internal: EventSubscriber from a blueprint.
  #
  # Returns an EventSubscriber.
  def event_subscriber
    @event_subscriber ||= EventSubscriber.make!(event: event)
  end

  # Internal: Registration from a blueprint.
  #
  # Returns a Registration.
  def registration
    @registration ||= Registration.make!(event: event)
  end

  # Internal: Registration from a blueprint.
  #
  # Returns a Registration.
  def temporary_registration
    @temporary_registration ||= TemporaryRegistration.make!(event: event)
  end

  # Internal: Destroys all AR objects created during preview.
  def destroy_fixtures
    temporary_registration.destroy if defined?(@temporary_registration)
    registration.destroy           if defined?(@registration)
    event_subscriber.destroy       if defined?(@event_subscriber)
    event.destroy                  if defined?(@event)
    lesson.destroy                 if defined?(@lesson)
  end
end
