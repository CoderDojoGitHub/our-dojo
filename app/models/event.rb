# Event represents each individual event. Records are stored in a database
# and have state. Look inside the state_machine block to see how events
# transition from a draft to completed.

class Event < ActiveRecord::Base
  # Public: Default class duration in hours.
  DefaultEventLengthInHours = 2

  # Public: Number of days before the event that registration opens.
  DaysToOpenRegistrationBeforeEvent = 7

  # Public: The number of students per class.
  DefaultClassSize = 20

  # Public: The lesson this event is for.
  # column :lesson_id
  validates :lesson_id, presence: true
  belongs_to :lesson

  # Public: Location of the event.
  # column :location
  validates :location, presence: true
  attr_accessible :location

  # Public: The start time for the event.
  # column :start_time
  validates :start_time, presence: true
  attr_accessible :start_time

  # Public: The end time for the event.
  # column :end_time
  attr_accessible :end_time

  # Public: The GitHub username of the event teacher.
  # column :teacher_github_username
  validates :teacher_github_username, presence: true
  attr_accessible :teacher_github_username

  # Public: Registrations for this event.
  has_many :registrations

  # Public: Subscribers to this event.
  has_many :event_subscribers

  # Public: Subscribers to this event that have not been sent a message.
  #
  # Returns an Array.
  def subscribers_to_notify
    event_subscribers.where(sent_at: nil)
  end

  # Public: Returns end_time or start_time + DefaultEventLengthInHours.
  #
  # Returns a Time.
  def end_time
    read_attribute(:end_time) || start_time + DefaultEventLengthInHours.hours
  end

  # Public: Upcoming event if one exists.
  #
  # Returns an Event or NilClass.
  def self.upcoming
    where("start_time > ?", Time.now).order("start_time ASC").first
  end

  # Public: Is registration open for this event?
  #
  # Returns a TrueClass or FalseClass.
  def open_for_registration?
    return false if completed?
    return false unless registration_date_passed?
    return false unless space_available?
    true
  end

  # Public: Has the date for this event already passed?
  #
  # Returns a TrueClass or FalseClass.
  def completed?
    start_time < Time.now
  end

  # Public: Is it close enough to the event for registration to be open?
  #
  # Returns a TrueClass or FalseClass.
  def registration_date_passed?
    start_time - DaysToOpenRegistrationBeforeEvent.days < Time.now
  end

  # Public: Is the registration date still in the future?
  #
  # Returns a TrueClass or FalseClass.
  def registration_date_still_in_the_future?
    !registration_date_passed?
  end

  # Public: Is there space available in the class?
  #
  # Returns a TrueClass or FalseClass.
  def space_available?
    total_students = registrations.
      inject(0) {|total, registration| total + registration.number_of_students }

    total_students < DefaultClassSize
  end
end
