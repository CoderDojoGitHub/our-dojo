class TemporaryRegistration < ActiveRecord::Base
  # Public: The event being registered for.
  # column :event_id
  validates :event_id, presence: true
  attr_accessible :event
  belongs_to :event

  # Public: String email of the registrant.
  # column :email
  validates :registrant_id, presence: true
  attr_accessible :registrant
  belongs_to :registrant

  # Public: The number of students being registered.
  # column :number_of_students
  validates :number_of_students, presence: true
  attr_accessible :number_of_students

  # Public: A unique token used for the confirm registration url.
  # column :reference_token
  attr_readonly :reference_token
  before_create :set_reference_token

  # Public: Sets the reference_token to a UUID without dashes.
  def set_reference_token
    uuid = SimpleUUID::UUID.new.to_guid
    self.reference_token = uuid.gsub("-", "")
  end
end
