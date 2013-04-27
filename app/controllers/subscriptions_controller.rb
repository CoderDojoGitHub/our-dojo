# Handles subscriptions.
class SubscriptionsController < ApplicationController

  # Public: Subscribes an email address to an event using EventSubscriber.
  def event
    event = Event.find(params[:id])

    if EventSubscriber.create(event: event, email: params[:email])
      flash[:notice] = "You will receive an email when registration opens for this event."
    else
      flash[:error] = "We were unable to subscribe #{params[:email]} for this event."
    end

    redirect_to lesson_path(event.lesson)
  end
end
