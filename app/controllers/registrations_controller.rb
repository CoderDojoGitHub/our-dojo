class RegistrationsController < ApplicationController

  # Public: Register for event. Requires params[:id], params[:email],
  # and params[:number_of_students].
  #
  # Creates Registrant if they do not already exist and then a
  # TemporaryRegistration for the Registrant for this Event.
  #
  # Redirects to Lesson.
  def register
    event = Event.find(params[:id])

    temporary_registration = Registrar.
      register(event, params[:email], params[:number_of_students])

    if temporary_registration.present? && temporary_registration.persisted?
      flash[:notice] = "Please check your email to confirm your registration."
    else
      flash[:error] = temporary_registration.errors.messages
    end

    redirect_to lesson_path(event.lesson)
  end
end