require "minitest_helper"

describe Repository do
  describe "#initialize" do
    it "requires organization_name and name" do
      proc { Repository.new }.must_raise(ArgumentError)
    end
  end

  describe "#name" do
    it "returns the name" do
      assert_equal "Bubbles", Repository.new("acme", "Bubbles").name
    end
  end

  describe "#organization_name" do
    it "returns the name" do
      assert_equal "acme", Repository.new("acme", "Bubbles").organization_name
    end
  end

  describe "#lesson?" do
    it "returns true if lesson.json exists for repository" do
      VCR.use_cassette "coderdojosf/Particles/lesson.json" do
        assert Repository.new("coderdojosf", "Particles").lesson?
      end
    end

    it "returns false if lesson.json does not exist for repository" do
      VCR.use_cassette "coderdojosf/event-app/lesson.json" do
        refute Repository.new("coderdojosf", "Bubbles").lesson?
      end
    end
  end

  describe "#lesson" do
    it "returns parsed lesson.json hash" do
      VCR.use_cassette "coderdojosf/Particles/lesson.json" do
        lesson = Repository.new("coderdojosf", "Particles").lesson
        assert "Animations in JavaScript", lesson["title"]
      end
    end
  end
end