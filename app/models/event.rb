# Event represents each individual event. Records are stored in a database
# and have state. Look inside the state_machine block to see how events
# transition from a draft to completed.

class Event < ActiveRecord::Base
  # Public: Default class duration in hours.
  DefaultEventLengthInHours = 2

  # Public: Number of days before the event that registration opens.
  DaysToOpenRegistrationBeforeEvent = 30

  # Public: The number of students per class.
  DefaultClassSize = 20

  # Public: The lesson this event is for.
  # column :lesson_id
  validates :lesson_id, presence: true
  belongs_to :lesson

  # Public: Location of the event.
  # column :location
  validates :location, presence: true
  # attr_accessible :location

  # Public: The start time for the event.
  # column :start_time
  validates :start_time, presence: true
  # attr_accessible :start_time

  # Public: Returns end_time or start_time + DefaultEventLengthInHours.
  # column :end_time
  #
  # Returns a Time.
  def end_time
    read_attribute(:end_time) || default_end_time
  end
  # attr_accessible :end_time

  # Public: Returns class_size or DefaultClassSize.
  # column :class_size
  #
  # Returns an Integer
  def class_size
    read_attribute(:class_size) || DefaultClassSize
  end
  # attr_accessible :class_size

  # Public: Default end_time based on start_time and DefaultEventLengthInHours.
  #
  # Returns a Time or NilClass.
  def default_end_time
    return if start_time.blank?
    start_time + DefaultEventLengthInHours.hours
  end

  # Public: The GitHub username of the event teacher.
  # column :teacher_github_username
  validates :teacher_github_username, presence: true
  # attr_accessible :teacher_github_username

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

  # Public: Upcoming events, if they exist
  #
  # count - the number of upcoming events to return
  #
  # Returns an array of up to `count` Events or NilClass.
  def self.upcoming(count = 1)
    where("start_time > ?", Time.now).order("start_time ASC").first(count)
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
    total_students < class_size
  end

  # Public: The number of already registered students.
  #
  # Returns an Integer.
  def total_students
    registrations.
      inject(0) {|total, registration| total + registration.number_of_students }
  end

  # Public: Display name for active admin.
  def display_name
    "#{lesson.title} - #{start_time.strftime("%A, %B %-d")}"
  end
end
