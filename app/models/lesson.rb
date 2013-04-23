class Lesson < ActiveRecord::Base
  attr_accessible :author_github_username, :events_attributes,
                  :repository, :summary, :title

  has_many :events

  validates_presence_of :repository, :title

  serialize :events_attributes

  # Public: Get upcoming event for lesson.
  #
  # Returns an Event.
  def upcoming_event
    events.where("start_time > ?", Time.now).order("start_time ASC").first
  end
end
