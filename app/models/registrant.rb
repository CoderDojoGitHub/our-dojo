require "email_validator"

class Registrant < ActiveRecord::Base
  # Public: Email of the registrant. Must be present and a valid email.
  # column :email
  attr_accessible :email
  validates :email, presence: true, email: true

  # Public: Has many temporary registrations.
  has_many :temporary_registrations

  # Public: Has many temporary registrations.
  has_many :registrations
end
