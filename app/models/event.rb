# Event represents each individual event. Records are stored in a database
# and have state. Look inside the state_machine block to see how events
# transition from a draft to completed.

class Event < ActiveRecord::Base
  # Public: Default class duration in hours.
  DefaultEventLengthInHours = 2

  # Public: The lesson this event is for.
  # column :lesson_id
  validates :lesson_id, presence: true
  belongs_to :lesson

  # Public: Event slug.
  # column :slug
  validates :slug, presence: true
  attr_accessible :slug

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
end
