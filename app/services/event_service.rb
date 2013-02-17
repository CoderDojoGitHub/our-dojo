# EventService handles scheduling, sending invites, and opening registration.

class EventService
  attr_reader :event

  def initialize(event)
    @event = event
  end

  # Public: Schedules the event.
  #
  # Returns a Boolean.
  def schedule
    true
  end

  # Public: Send invites.
  #
  # Returns a Boolean
  def send_invites
    true
  end

  # Public: Open registration.
  #
  # Returns a Boolean
  def open_registration
    true
  end
end