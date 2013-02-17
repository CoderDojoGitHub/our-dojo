class EventbriteHelper
  # Public: Format time object for Eventbrite API.
  #
  #   time - A Time object
  #
  # Returns a String.
  def self.formatted_datetime(time)
    time.strftime("%Y-%m-%d %H:%M:%S")
  end
end