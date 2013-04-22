class EventImporter
  attr_reader :lessons

  # Public: Called by .new while instantiating the object.
  #
  # lessons - lessons to import events from.
  def initialize(lessons)
    @lessons = lessons
  end

  # Public: Import events from lessons.
  #
  # Returns an Array.
  def import
    lessons.map do |lesson|
      process_events(lesson, lesson.events)
    end.flatten.compact
  end

  # Internal: Process events.
  #
  # Returns an Array.
  def process_events(lesson, events)
    return if events.blank?

    lesson.events.map do |event_attributes|
      process_event(event_attributes, lesson.repository)
    end
  end

  # Internal: Find and update or create event.
  #
  # Returns an Event or NilClass.
  def process_event(event_attributes, repository)
    start_time = Time.parse(event_attributes["date"])
    event_date = start_time.strftime("%Y%m%d")
    event_slug = "#{repository}-#{event_date}"
    event = Event.find_or_initialize_by_slug(event_slug)
    event.start_time = start_time
    event.teacher_github_username = event_attributes["teacher_github_username"]

    if event["length_in_hours"].present?
      event.end_time = start_time + event_attributes["length_in_hours"].hours
    end

    if event.changed?
      event.save
      event
    end
  end
end