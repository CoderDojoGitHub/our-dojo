namespace :registration do
  desc "Send event notifications to subscribers."
  task send_notifications: :environment do
    events = Event.upcoming
    
    events.each do |event|
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
    end

    Rails.logger.info "REGISTRATION: There are no upcoming events." unless events.any?
  end
end

namespace :import do
  desc "Import lessons and events."
  task lessons_and_events: :environment do
    Import.lessons_and_events
  end
end
