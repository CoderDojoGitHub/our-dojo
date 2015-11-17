class EventImporter
  # Public: Lessons passed in during initialization.
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
      process_events(lesson, lesson.events_attributes)
    end.flatten.compact
  end

  # Internal: Process events.
  #
  # Returns an Array.
  def process_events(lesson, events_attributes)
    return if events_attributes.blank?

    events_attributes.map do |event_attributes|
      process_event(event_attributes, lesson.repository, lesson.id)
    end
  end

  # Internal: Find and update or create event.
  #
  # Returns an Event or NilClass.
  def process_event(event_attributes, repository, lesson_id)
    start_time = Time.parse(event_attributes["date"])
    event_date = start_time.strftime("%Y%m%d")
    event = Event.find_or_initialize_by_lesson_id_and_start_time(lesson_id, start_time)
    event.lesson_id = lesson_id
    event.location = event_attributes["location"]
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
