require "email_validator"

class Registrant < ActiveRecord::Base
  # Public: Email of the registrant. Must be present and a valid email.
  # column :email
  validates :email, presence: true, email: true

  # Public: Has many temporary registrations.
  has_many :temporary_registrations, :dependent => :destroy

  # Public: Has many temporary registrations.
  has_many :registrations, :dependent => :destroy

  # Public: Display name for active admin.
  def display_name
    email
  end
end
