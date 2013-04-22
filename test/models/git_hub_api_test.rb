require "minitest_helper"

describe GitHubApi do
  describe ".api_call" do
    it "returns decoded data for resource from the GitHub API" do
      VCR.use_cassette "coderdojosf/event-app" do
        resource = GitHubApi.api_call("repos/coderdojosf/event-app")
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

  describe ".parsed_file_contents" do
    it "returns Hash of parsed file contents" do
      VCR.use_cassette "coderdojosf/Particles/lesson.json parsed file contents" do
        lesson_attributes = GitHubApi.parsed_file_contents("repos/coderdojosf/Particles/contents/lesson.json")
        assert_equal "Animations in Javascript", lesson_attributes["title"]
        assert_equal "Build animations in the web browser using javascript and the D3.js library.", lesson_attributes["summary"]
      end
    end
  end
end