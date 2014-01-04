class RegistrationsController < ApplicationController

  # Public: Register for event. Requires params[:id], params[:email],
  # and params[:number_of_students].
  #
  # Creates Registrant if they do not already exist and then a
  # TemporaryRegistration for the Registrant for this Event.
  #
  # Sends email to registrant asking them to confirm their registration.
  #
  # Redirects to Lesson.
  def register
    event = Event.find(params[:id])

    temporary_registration = Registrar.
      register(event, params[:email], params[:number_of_students])

    if temporary_registration.persisted?
      RegistrationMailer.confirm(temporary_registration.id).deliver

      flash[:notice] = "Please check your email to confirm your registration."
    else
      flash[:error] = "Registration failed because #{temporary_registration.errors.messages.map {|k, v| "#{k.to_s.gsub("_", " ")} #{v.first}" }.join(", ")}"
    end

    redirect_to lesson_path(event.lesson, :anchor => "registration")
  end

  # Public: Confirm registration for an event.
  #
  # Turns TemporaryRegistration into Registration.
  #
  # Sends email to registrant confirming their registration.
  #
  # Redirects to Lesson.
  def confirm
    temporary_registration =
      TemporaryRegistration.find_by_reference_token(params[:id])

    registration = Registrar.confirm_registration(temporary_registration)

    if registration.present? && registration.persisted?
      RegistrationMailer.confirmed(registration.id).deliver

      flash[:notice] = "You registration is confirmed!"
    else
      flash[:error] = "We were unable to register you for this class."
    end

    redirect_to lesson_path(temporary_registration.event.lesson, :anchor => "registration")
  end
end
