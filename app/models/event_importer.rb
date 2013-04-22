class EventImporter
  attr_reader :lessons

  # Public: Called by .new while instantiating the object.
  #
  # lessons - lessons to import events from.
  def initialize(lessons)
    @lessons = lessons
  end

  def import
    lessons.map do |lesson|
      next unless lesson.events.present?

      lesson.events.map do |event_attributes|
        start_time = Time.parse(event_attributes["date"])
        event_date = start_time.strftime("%Y%m%d")
        event_slug = "#{lesson.repository}-#{event_date}"
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
    end.flatten.compact
  end
end