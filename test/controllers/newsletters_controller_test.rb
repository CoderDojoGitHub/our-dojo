require "minitest_helper"

describe NewslettersController do
  describe "#announcements" do
    it "returns hash with email on success" do
      VCR.use_cassette("subscribe_to_list") do
        post :announcements, :email => "jonmagic@gmail.com"

        assert_equal "200", response.code
        assert_equal \
          "{\"email\":\"jonmagic@gmail.com\"}",
          response.body
      end
    end

    it "returns error message on failure" do
      VCR.use_cassette("already_subscribed_to_list") do
        post :announcements, :email => "jonmagic@gmail.com"

        assert_equal "422", response.code
        assert_equal \
          "Looks like jonmagic@gmail.com is already subscribed to the list!",
          response.body
      end
    end
  end
end
