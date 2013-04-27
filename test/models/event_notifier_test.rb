require "minitest_helper"

describe EventNotifier do
  describe "#event" do
    it "returns event passed in at instantiation" do
      event = stub

      assert_equal event, EventNotifier.new(event).event
    end
  end

  describe "#delivered_to_subscribers" do
    it "is empty array upon instantation" do
      assert_equal [], EventNotifier.new(stub).delivered_to_subscribers
    end
  end

  describe "#send" do
    it "delivers messages to subscribers" do
      subscriber = EventSubscriber.make!
      event = subscriber.event
      event_notifier = EventNotifier.new(event)
      message = stub

      message.expects(:deliver).returns(true)
      event_notifier.expects(:subscribers).returns([subscriber])
      RegistrationMailer.
        expects(:open).
        with(event.id, subscriber.id).
        returns(message)

      event_notifier.send
      assert_equal [subscriber], event_notifier.delivered_to_subscribers
    end

    it "returns EventNotifier" do
      event = stub
      event_notifier = EventNotifier.new(event)
      event_notifier.stubs(subscribers: [])

      assert_equal event_notifier, event_notifier.send
    end

    it "does not send message if subscriber.sent_at is set" do
      subscriber = EventSubscriber.make!
      event = subscriber.event
      event_notifier = EventNotifier.new(event)
      event_notifier.stubs(subscribers: [subscriber])

      subscriber.expects(:sent_at?).returns(true)
      RegistrationMailer.expects(:open).never

      event_notifier.send
      assert_equal [], event_notifier.delivered_to_subscribers
    end
  end

  describe "#subscribers" do
    it "returns subscribers from event" do
      event = stub
      subscribers = []

      event.expects(:event_subscribers).returns(subscribers)
      assert_equal subscribers, EventNotifier.new(event).subscribers
    end
  end
end
