class Registrar
  # Public: Creates registrant from email and then creates a temporary
  # registration for that registrant for the event.
  #
  # event - Event being registered for.
  # email - Email address of the registrant.
  # number_of_students - The number of students being registered.
  #
  # Returns a TemporaryRegistration.
  def self.register(event, email, number_of_students)
    registrant = Registrant.find_or_create_by_email(email)
    return registrant unless registrant.persisted?

    temporary_registration = TemporaryRegistration.
      find_or_initialize_by_event_id_and_registrant_id(event.id, registrant.id)

    temporary_registration.number_of_students = number_of_students
    temporary_registration.save
    temporary_registration
  end

  # Public: Creates a registration from the temporary registration and
  # then removes the temporary registration.
  #
  # temporary_registration - TemporaryRegistration to be confirmed.
  #
  # Returns a Registration.
  def self.confirm_registration(temporary_registration)
    registration = Registration.
      find_or_initialize_by_reference_token(temporary_registration.reference_token)

    registration.event_id = temporary_registration.event_id
    registration.registrant_id = temporary_registration.registrant_id
    registration.number_of_students = temporary_registration.number_of_students
    registration.temporary_registration_at = temporary_registration.created_at

    if registration.save
      temporary_registration.destroy
    end

    registration
  end
end
