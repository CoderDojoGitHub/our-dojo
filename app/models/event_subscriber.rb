require "email_validator"

class EventSubscriber < ActiveRecord::Base
  # Public: Email of the subscriber. Must be present and a valid email.
  # column :email
  attr_accessible :email
  validates :email, presence: true, email: true

  # Public: The event the subscriber is subscribing to.
  # column :event_id
  attr_accessible :event
  validates :event, presence: true
  belongs_to :event

  # Public: Time that the email was sent to the subscriber.
  # column :sent_at
  attr_readonly :sent_at
end
