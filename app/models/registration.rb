# A Registration represents a single reservation for an Event for a Registrant.
# It belongs to an Event and a Registrant and also stores the number of students
# being registered.
class Registration < ActiveRecord::Base

  # Public: The event being registered for.
  # column :event_id
  validates :event_id, presence: true
  belongs_to :event

  # Public: Registrant this registration belongs to.
  # column :registrant_id
  validates :registrant_id, presence: true
  belongs_to :registrant

  # Public: The number of students being registered.
  # column :number_of_students
  validates :number_of_students, presence: true

  # Public: A unique token used for the confirm registration url.
  # column :reference_token
  validates :reference_token, presence: true

  # Public: Time of the temporary registration. Compare against created_at
  # to see time between registering and confirming registration.
  # column :temporary_registration_at
  validates :temporary_registration_at, presence: true
end
