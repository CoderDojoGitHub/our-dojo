# Send messages to event subscribers using the RegistrationMailer.
# Protects from a single instance sending
class EventNotifier

  # Public: Called by .new while instantiating the object.
  #
  # event - Event that messages are being sent for.
  def initialize(event)
    @event = event
    @delivered_to_subscribers = []
  end

  # Public: Event that messages are being sent for.
  #
  # Returns an Event.
  attr_reader :event

  # Public: The subscribers that messages were delivered to.
  #
  # Returns an Array.
  attr_reader :delivered_to_subscribers

  # Public: Send open registation messages to the subscribers for this event.
  #
  # Returns an EventNotifier or NilClass.
  def send
    subscribers.each do |subscriber|
      return if subscriber.sent_at?

      message = RegistrationMailer.open(event.id, subscriber.id)
      message.deliver

      subscriber.update_attributes(sent_at: Time.now)
      @delivered_to_subscribers << subscriber
    end

    self
  end

  # Public: Subscribers to this event.
  #
  # Returns an Array.
  def subscribers
    event.event_subscribers
  end
end
