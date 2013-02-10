ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require "minitest/autorun"
require "minitest/rails"

# Add `gem "minitest/rails/capybara"` to the test group of your Gemfile
# and uncomment the following if you want Capybara feature tests
# require "minitest/rails/capybara"

# Uncomment if you want awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

def build_event(attributes=nil)
  attributes = attributes || {}
  Event.new(party_event_attributes.merge(attributes))
end

def create_event(attributes=nil)
  event = build_event(attributes)
  event.save
  event
end

def party_event_attributes
  {
    title: "Party!",
    start_time: 24.hours.from_now,
  }
end