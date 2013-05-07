class Lesson < ActiveRecord::Base
  # Public: Title of the lesson. The title must be present to save the record.
  # column :title
  validates :title, presence: true

  # Public: Summary of the lesson plan.
  # column :summary

  # Public: The lesson authors github username.
  # column :author_github_username

  # Public: The repository name where the lesson is stored. The repository
  # must be present to save the record.
  # column :repository
  validates :repository, presence: true

  # Public: A serialized array of event hashes with their attributes.
  # column :events_attributes
  serialize :events_attributes

  # Public: The lesson may have many events.
  has_many :events

  # Public: Get upcoming event for lesson.
  #
  # Returns an Event.
  def upcoming_event
    @upcoming_event ||= events.where("start_time > ?", Time.now).order("start_time ASC").first
  end

  # Public: Most recent lesson.
  #
  # Returns a Lesson.
  def self.most_recent
    order("created_at DESC").first
  end
end
