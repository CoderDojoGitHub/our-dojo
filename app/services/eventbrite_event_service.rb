# EventbriteEventService handles scheduling, sending invites, and opening
# registration on Eventbrite.

class EventbriteEventService < EventService
  # Public: Schedules the event.
  #
  # Returns a TrueClass or FalseClass.
  def schedule
    response = eventbrite.event_new(eventbrite_event_attributes)
    return false unless response.code == 200
    eventbrite_event_id = response.parsed_response["process"]["id"]
    event.update_attributes(eventbrite_event_id: eventbrite_event_id)
  end

  # Public: Send invites.
  #
  # Returns a TrueClass or FalseClass.
  def send_invites
    true
  end

  # Public: Open registration.
  #
  # Returns a TrueClass or FalseClass.
  def open_registration
    true
  end

  # Internal: Eventbrite client.
  def eventbrite
    $eventbrite
  end

  # Internal: Eventbrite event attributes.
  def eventbrite_event_attributes
    {
      title: event.title,
      start_date: EventbriteHelper.formatted_datetime(event.start_time),
      end_date: EventbriteHelper.formatted_datetime(event.end_time),
      privacy: 1,
      status: "draft",
      venue_id: ENV["EVENTBRITE_VENUE_ID"],
      capacity: 20,
      personalized_url: ENV["EVENTBRITE_PERSONALIZED_URL"],
    }
  end
end

