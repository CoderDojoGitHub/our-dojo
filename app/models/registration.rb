class Registration < ActiveRecord::Base
  # Public: The event being registered for.
  # column :event_id
  validates :event_id, presence: true
  attr_accessible :event, :event_id
  belongs_to :event

  # Public: String email of the registrant.
  # column :email
  validates :registrant_id, presence: true
  attr_accessible :registrant, :registrant_id
  belongs_to :registrant

  # Public: The number of students being registered.
  # column :number_of_students
  validates :number_of_students, presence: true
  attr_accessible :number_of_students

  # Public: A unique token used for the confirm registration url.
  # column :reference_token
  validates :reference_token, presence: true
  attr_accessible :reference_token

  # Public: Time of the temporary registration. Compare against created_at
  # to see time between registering and confirming registration.
  # column :temporary_registration_at
  validates :temporary_registration_at, presence: true
  attr_accessible :temporary_registration_at
end
