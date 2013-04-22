ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)

require "minitest/autorun"
require "minitest/rails"
require "capybara/rails"
require "webmock/minitest"
require "blueprints"

# Add `gem "minitest/rails/capybara"` to the test group of your Gemfile
# and uncomment the following if you want Capybara feature tests
# require "minitest/rails/capybara"

# Uncomment if you want awesome colorful output
require "minitest/pride"

class ActiveSupport::TestCase; end

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
end

class AcceptanceTest < MiniTest::Spec
  include Capybara::RSpecMatchers
  include Capybara::DSL
end

# Public: Load fixture file from fixtures directory.
#
# name - Filename without extension.
# extension - File extension name, defaults to json.
#
# Returns a String.
def fixture(name, extension="json")
  File.read(Rails.root.join("test", "fixtures", "#{name}.#{extension}"))
end

# Public: Return a hash or array built from json fixture.
#
# name - Filename without extension.
#
# Returns a Hash or Array.
def json_fixture(name)
  YAML.load(fixture(name))
end