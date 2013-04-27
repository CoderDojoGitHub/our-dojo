require "minitest_helper"

describe Organization do
  describe "#new" do
    it "expects organization username" do
      proc { Organization.new }.must_raise(ArgumentError)
    end
  end

  describe "#username" do
    it "returns the organization username" do
      assert_equal "acme", Organization.new("acme").username
    end
  end

  describe "#repositories" do
    it "returns array of organizations repositores on GitHub" do
      VCR.use_cassette "coderdojosf/repositories" do
        repositories = Organization.new("coderdojosf").repositories
        assert_equal Array, repositories.class
        refute repositories.empty?
      end
    end
  end

  describe "#lesson_repositories" do
    it "returns array of lesson repositories which contains 'Particles'" do
      VCR.use_cassette "coderdojosf/lesson_repositories" do
        lesson_repositories = Organization.new("coderdojosf").lesson_repositories
        assert_equal Array, lesson_repositories.class
        assert lesson_repositories.select {|repository| repository.name == "Particles" }.present?
      end
    end
  end
end
