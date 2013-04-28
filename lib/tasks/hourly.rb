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
    Import.lessons_and_events
  end
end
