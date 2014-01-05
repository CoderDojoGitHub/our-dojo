require "minitest_helper"

describe EmailList do
  before do
    @email_list = EmailList.new("ANNOUNCEMENTS_LIST_ID")
  end

  describe ".announcements" do
    it "creates instance with ANNOUNCEMENTS_LIST_ID" do
      EmailList.expects(:new).with("1234")
      EmailList.announcements
    end
  end

  describe "#subscribe" do
    it "returns nil on success" do
      VCR.use_cassette("subscribe_to_list") do
        assert_nil @email_list.subscribe("jonmagic@gmail.com")
      end
    end

    it "returns error message on already subscribed error" do
      VCR.use_cassette("already_subscribed_to_list") do
        assert_equal \
          "Looks like jonmagic@gmail.com is already subscribed to the list!",
          @email_list.subscribe("jonmagic@gmail.com")
      end
    end

    it "returns error message on list does not exist" do
      VCR.use_cassette("list_does_not_exist") do
        email_list = EmailList.new("fake_list")
        assert_equal \
          "We're having an issue adding your email. Try it again.",
          email_list.subscribe("jonmagic@gmail.com")
      end
    end
  end
end
