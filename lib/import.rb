module Import
  def self.lessons_and_events
    organization = Organization.new(ENV["GITHUB_ORGANIZATION"])
    lesson_importer = LessonImporter.new(organization)

    lessons = lesson_importer.import
    lessons.each do |lesson|
      Rails.logger.info "IMPORT: Lesson (#{lesson.id}) from repository #{organization.username}/#{lesson.repository} has been imported."
    end

    event_importer = EventImporter.new(lessons)
    events = event_importer.import
    events.each do |event|
      Rails.logger.info "IMPORT: Event (#{event.id}) from lesson with repository #{organization.username}/#{event.lesson.repository} has been imported."
    end
  end
end
