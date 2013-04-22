require "minitest_helper"

describe GitHubApi do
  describe ".parsed_response" do
    it "returns decoded data for resource from the GitHub API" do
      VCR.use_cassette "coderdojosf/event-app" do
        resource = GitHubApi.parsed_response("repos/coderdojosf/event-app")
        assert_equal "event-app", resource["name"]
      end
    end
  end

  describe ".code" do
    it "returns decoded data for resource from the GitHub API" do
      VCR.use_cassette "coderdojosf/event-app" do
        code = GitHubApi.code("repos/coderdojosf/event-app")
        assert_equal 200, code
      end
    end
  end
end