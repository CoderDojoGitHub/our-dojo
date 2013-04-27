namespace :registration do
  task send_notifications: :environment do
    if event = Event.upcoming
      if event.open_for_registration?
        Rails.logger.info "REGISTRATION: Preparing to send open registration emails for event_id #{event.id}."
        event_notifier = EventNotifier.new(event)
        event_notifier.send

        event_notifier.delivered_to_subscribers.each do |subscriber|
          Rails.logger.info "REGISTRATION: Open registration email sent to #{subscriber.email} for event_id #{event.id}."
        end
      else
        Rails.logger.info "REGISTRATION: Registration for event_id #{event.id} is not yet open."
      end
    else
      Rails.logger.info "REGISTRATION: There are no upcoming events."
    end
  end
end

namespace :import do
  task lessons_and_events: :environment do
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
