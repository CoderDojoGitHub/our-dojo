require "minitest_helper"

describe Event do
  before do
    @event = create_event
  end

  describe "State transitions" do
    it "transitions" do
      # Event#schedule_event
      assert_nil @event.scheduled_at
      @event.draft?.must_equal true
      @event.event_created?.must_equal false
      @event.schedule_event
      @event.draft?.must_equal false
      refute_nil @event.scheduled_at

      # Event#send_invites
      assert_nil @event.invites_sent_at
      @event.event_created?.must_equal true
      @event.invites_sent?.must_equal false
      @event.send_invites
      @event.event_created?.must_equal false
      refute_nil @event.invites_sent_at

      # Event#open_registration
      assert_nil @event.opened_registration_at
      @event.invites_sent?.must_equal true
      @event.registration_opened?.must_equal false
      @event.open_registration
      @event.invites_sent?.must_equal false
      refute_nil @event.opened_registration_at

      # Event#complete
      @event.registration_opened?.must_equal true
      @event.completed?.must_equal false
      @event.complete
      @event.registration_opened?.must_equal false
      @event.completed?.must_equal true
    end
  end
end
