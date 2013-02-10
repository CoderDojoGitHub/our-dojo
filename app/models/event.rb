# Event represents each individual event. Records are stored in a database
# and have state. Look inside the state_machine block to see how events
# transition from a draft to completed.

class Event < ActiveRecord::Base

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
  attr_accessible :name, :start_time, :end_time, :state, :eventbrite_event_created_at, :invites_sent_at, :opened_registration_at

  # Internal: Validations for attributes.
  validates_presence_of :name, :start_time, :end_time

  state_machine :state, initial: :draft do

    # Create states based on the Event::States constant.
    States.each do |name, value|
      state name, value: value
    end

    # Public: Schedule the event.
    event :schedule_event do
      transition draft: :event_created
    end
    before_transition on: :schedule_event, do: :create_eventbrite_event
    after_transition  on: :schedule_event, do: lambda {|event| event.update_attributes(eventbrite_event_created_at: Time.now) }

    # Public: Send invites to recent attendies.
    event :send_invites do
      transition event_created: :invites_sent
    end
    before_transition on: :send_invites, do: :send_eventbrite_invites
    after_transition  on: :send_invites, do: lambda {|event| event.update_attributes(invites_sent_at: Time.now) }

    # Public: Open registration to the public.
    event :open_registration do
      transition invites_sent: :registration_opened
    end
    before_transition on: :open_registration, do: :open_eventbrite_registration
    after_transition  on: :open_registration, do: lambda {|event| event.update_attributes(opened_registration_at: Time.now) }

    # Public: Complete the event.
    event :complete do
      transition registration_opened: :completed
    end
  end

  # Internal: Create the event on Eventbrite.
  def create_eventbrite_event
    Rails.logger.info "Eventbrite event created."
  end

  # Internal: Send invites on Eventbrite.
  def send_eventbrite_invites
    Rails.logger.info "Eventbrite invites sent."
  end

  # Internal: Open registration on Eventbrite.
  def open_eventbrite_registration
    Rails.logger.info "Eventbrite registration opened."
  end

  # Public: Party event for testing in the console.
  def self.party
    new(name: "Party!", start_time: 24.hours.from_now, end_time: 26.hours.from_now)
  end
end
