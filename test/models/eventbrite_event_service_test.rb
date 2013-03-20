require "minitest_helper"
require "fake_eventbrite_client"

describe EventbriteEventService do
  before do
    @previous_eventbrite_event_id = "4321"
    @previous_event = create_event(title: "previous", start_time: 1.day.ago, eventbrite_event_id: @previous_eventbrite_event_id)

    @title = "Birthday party!"
    @start_time = 2.days.from_now
    @event = create_event(title: @title, start_time: @start_time)

    @eventbrite_event_service = EventbriteEventService.new(@event)
    @eventbrite_event_id = "1234"
    @fake_eventbrite_client = FakeEventbriteClient.new(id: @eventbrite_event_id)
  end

  describe "#copy_event" do
    it "copies previous event on Eventbrite" do
      eventbrite_client_mock = MiniTest::Mock.new

      @eventbrite_event_service.stub :eventbrite, eventbrite_client_mock do
        eventbrite_client_mock.expect(:event_copy, @fake_eventbrite_client.event_copy, [{
          event_id: @previous_eventbrite_event_id,
          event_name: @title,
        }])

        @eventbrite_event_service.copy_event
      end
    end

    it "sets eventbrite_event_id on the event" do
      @eventbrite_event_service.stub :eventbrite, @fake_eventbrite_client do
        assert_nil @event.eventbrite_event_id
        @eventbrite_event_service.copy_event
        assert_equal @event.eventbrite_event_id, @eventbrite_event_id
      end
    end

    it "returns TrueClass" do
      @eventbrite_event_service.stub :eventbrite, @fake_eventbrite_client do
        assert_instance_of TrueClass, @eventbrite_event_service.copy_event
      end
    end
  end

  describe "#update_event" do
    it "updates Eventbrite event start_date and end_date, publishes the event, and sets it to private" do
      eventbrite_client_mock = MiniTest::Mock.new
      @event.update_attributes(eventbrite_event_id: @eventbrite_event_id)

      @eventbrite_event_service.stub :eventbrite, eventbrite_client_mock do
        eventbrite_client_mock.expect(:event_update, @fake_eventbrite_client.event_update, [{
          id: @eventbrite_event_id,
          start_date: EventbriteHelper.formatted_datetime(@event.start_time),
          end_date: EventbriteHelper.formatted_datetime(@event.end_time),
          status: "live",
          privacy: 0,
        }])

        @eventbrite_event_service.update_event
      end
    end
  end

  describe "#update_ticket" do
    it "updates Eventbrite ticket start_date and end_date" do
      eventbrite_client_mock = MiniTest::Mock.new
      @event.update_attributes(eventbrite_event_id: @eventbrite_event_id)
      @eventbrite_event_service.stub :eventbrite_ticket_id, 5555 do

        @eventbrite_event_service.stub :eventbrite, eventbrite_client_mock do
          eventbrite_client_mock.expect(:ticket_update, @fake_eventbrite_client.ticket_update, [{
            id: 5555,
            start_date: EventbriteHelper.formatted_datetime(@event.start_time - Event::OpenTicketsBeforeEventInDays.days),
            end_date: EventbriteHelper.formatted_datetime(@event.start_time),
          }])

          @eventbrite_event_service.update_ticket
        end
      end
    end
  end

  describe "#eventbrite_ticket_id" do
    it "returns ticket id" do
      eventbrite_event = {
        "event" => {
          "tickets" => [
            {
              "ticket" => {
                "id" => 911
              }
            }
          ]
        }
      }

      @eventbrite_event_service.stub :eventbrite_event, eventbrite_event do
        @eventbrite_event_service.eventbrite_ticket_id.must_equal 911
      end
    end
  end

  describe "#open_registration" do
    it "sets the Eventbrite event to public" do
      eventbrite_client_mock = MiniTest::Mock.new
      @event.update_attributes(eventbrite_event_id: @eventbrite_event_id)

      @eventbrite_event_service.stub :eventbrite, eventbrite_client_mock do
        eventbrite_client_mock.expect(:event_update, @fake_eventbrite_client.event_update, [{
          id: @eventbrite_event_id,
          privacy: 1,
        }])

        @eventbrite_event_service.open_registration
      end
    end
  end
end
