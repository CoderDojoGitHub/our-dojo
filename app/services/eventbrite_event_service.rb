# EventbriteEventService handles scheduling, sending invites, and opening
# registration on Eventbrite.

class EventbriteEventService < EventService
  # Public: Schedules the event.
  def schedule
    copy_event
    update_event
    update_ticket
  end

  # Internal: Copy the previous event on Eventbrite and set the
  # eventbrite_event_id on the current event.
  #
  # Returns a TrueClass or FalseClass.
  def copy_event
    response = eventbrite.event_copy({
      event_id: previous_event.eventbrite_event_id,
      event_name: event.title,
    })
    event.update_attributes(eventbrite_event_id: response.parsed_response["process"]["id"])
  end

  # Internal: Update the Eventbrite event start_time and end_time
  # to match our event.
  #
  # Returns a Hash.
  def update_event
    eventbrite.event_update({
      id: event.eventbrite_event_id,
      start_date: EventbriteHelper.formatted_datetime(event.start_time),
      end_date: EventbriteHelper.formatted_datetime(event.end_time),
      status: "live",
      privacy: 0,
    })
  end

  # Internal: Update the Eventbrite tickets for this event.
  #
  # Returns a Hash.
  def update_ticket
    eventbrite.ticket_update({
      id: eventbrite_ticket_id,
      start_date: EventbriteHelper.formatted_datetime(open_ticket_sales_on),
      end_date: EventbriteHelper.formatted_datetime(close_ticket_sales_on),
    })
  end

  # Public: Open registration.
  #
  # Returns a TrueClass or FalseClass.
  def open_registration
    # Does this need to be more than a state change? If tickets are already
    # set to go on sale on a certain date I'm not sure we need to.
    true
  end

  # Internal: Eventbrite client.
  #
  # Returns EventbriteClient.
  def eventbrite
    $eventbrite
  end

  # Internal: Previous event.
  #
  # Returns an Event.
  def previous_event
    event.previous_event
  end

  # Internal: Eventbrite ticket id.
  #
  # Returns an Integer.
  def eventbrite_ticket_id
    eventbrite_event["event"]["tickets"].first["ticket"]["id"]
  end

  # Internal: Eventbrite event_get response.
  #
  # Returns a Hash.
  def eventbrite_event
    @eventbrite_event ||= begin
      eventbrite.event_get(id: event.eventbrite_event_id)
    end
  end

  # Internal: Date and time to open ticket sales.
  #
  # Returns an Time.
  def open_ticket_sales_on
    event.start_time - Event::OpenTicketsBeforeEventInDays.days
  end

  # Internal: Date and time to close ticket sales.
  #
  # Returns an Time.
  def close_ticket_sales_on
    event.start_time
  end
end

