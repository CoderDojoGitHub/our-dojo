require "minitest_helper"
require "fake_eventbrite_client"

describe EventbriteEventService do
  before do
    @title = "Birthday party!"
    @start_time = 2.days.from_now
    @event = create_event(title: @title, start_time: @start_time)
    @eventbrite_event_service = EventbriteEventService.new(@event)
    @eventbrite_event_id = 1234
    @fake_eventbrite_client = FakeEventbriteClient.new(id: @eventbrite_event_id)
  end

  describe "#schedule" do
    it "creates the event on Eventbrite" do
      eventbrite_client_mock = MiniTest::Mock.new

      @eventbrite_event_service.stub :eventbrite, eventbrite_client_mock do
        eventbrite_client_mock.expect(:event_new, @fake_eventbrite_client.event_new, [{
          title: @title,
          start_date: @start_time.strftime("%Y-%m-%d %H:%M:%S"),
          end_date: (@start_time + Event::DefaultEventLengthInHours.hours).strftime("%Y-%m-%d %H:%M:%S"),
          privacy: 1,
          status: "draft",
          venue_id: ENV["EVENTBRITE_VENUE_ID"],
          capacity: Event::DefaultEventCapacity,
          personalized_url: ENV["EVENTBRITE_PERSONALIZED_URL"],
        }])

        @eventbrite_event_service.schedule
      end
    end

    it "sets eventbrite_event_id on the event" do
      @eventbrite_event_service.stub :eventbrite, @fake_eventbrite_client do
        assert_nil @event.eventbrite_event_id
        @eventbrite_event_service.schedule
        assert_equal @event.eventbrite_event_id, @eventbrite_event_id
      end
    end

    it "returns TrueClass" do
      @eventbrite_event_service.stub :eventbrite, @fake_eventbrite_client do
        assert_instance_of TrueClass, @eventbrite_event_service.schedule
      end
    end
  end
end