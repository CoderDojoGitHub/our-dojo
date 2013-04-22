# Event represents each individual event. Records are stored in a database
# and have state. Look inside the state_machine block to see how events
# transition from a draft to completed.

class Event < ActiveRecord::Base
  DefaultEventLengthInHours = 2

  attr_accessible :start_time, :end_time, :slug

  # Public: end_time or start_time + DefaultEventLengthInHours.
  #
  # Returns a Time.
  def end_time
    read_attribute(:end_time) || start_time + DefaultEventLengthInHours.hours
  end
end
