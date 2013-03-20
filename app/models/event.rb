# Event represents each individual event. Records are stored in a database
# and have state. Look inside the state_machine block to see how events
# transition from a draft to completed.

class Event < ActiveRecord::Base

  DefaultEventLengthInHours = 2
  OpenTicketsBeforeEventInDays = 7
  DefaultEventCapacity = 20

  # Public: Event::States keys/values for the Event state machine.
  #
  # Returns a Hash.
  States = {
    draft: 0,
    event_created: 1,
    invites_sent: 2,
    registration_opened: 3,
    completed: 4,
  }

  # Internal: Set attributes as accessible. Protects all attributes not
  # specifically designated here.
  attr_accessible :title, :start_time, :start_date, :end_time, :state, :scheduled_at,
                  :invites_sent_at, :opened_registration_at, :eventbrite_event_id

  # Internal: Validations for attributes.
  validates_presence_of :title, :start_time

  def start_date=(start_date)
    self.start_time = Time.parse("#{start_date} 12:00:00")
  end

  def start_date
    return if start_time.blank?
    start_time.strftime("%Y-%m-%d")
  end

  state_machine :state, initial: :draft do

    # Create states based on the Event::States constant.
    States.each do |name, value|
      state name, value: value
    end

    # Public: Schedule the event.
    event :schedule_event do
      transition draft: :event_created
    end
    before_transition on: :schedule_event, do: :schedule_event_with_event_service
    after_transition  on: :schedule_event, do: lambda {|event| event.update_attributes(scheduled_at: Time.now) }

    # Public: Send invites to recent attendies.
    event :send_invites do
      transition event_created: :invites_sent
    end
    before_transition on: :send_invites, do: :send_invites_with_event_service
    after_transition  on: :send_invites, do: lambda {|event| event.update_attributes(invites_sent_at: Time.now) }

    # Public: Open registration to the public.
    event :open_registration do
      transition invites_sent: :registration_opened
    end
    before_transition on: :open_registration, do: :open_registration_with_event_service
    after_transition  on: :open_registration, do: lambda {|event| event.update_attributes(opened_registration_at: Time.now) }

    # Public: Complete the event.
    event :complete do
      transition registration_opened: :completed
    end
  end

  # Public: end_time or start_time + DefaultEventLengthInHours.
  def end_time
    read_attribute(:end_time) || start_time + DefaultEventLengthInHours.hours
  end

  def previous_event
    self.class.where("start_time < ?", self.start_time).last
  end

  # Internal: The event service to use for scheduling, sending invites, and
  # to open registration.
  #
  # Returns an EventbriteEventService.
  def event_service
    @event_service ||= EventbriteEventService.new(self)
  end

  # Internal: Schedule the event using the event service.
  #
  # Returns a Boolean.
  def schedule_event_with_event_service
    event_service.schedule
  end

  # Internal: Send invites using the event service.
  #
  # Returns a Boolean.
  def send_invites_with_event_service
    event_service.send_invites
  end

  # Internal: Open registration using the event service.
  #
  # Returns a Boolean.
  def open_registration_with_event_service
    event_service.open_registration
  end
end
