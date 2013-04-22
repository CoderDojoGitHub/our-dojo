require "minitest_helper"

describe LessonImporter do
  describe "#import" do
    it "creates lessons for lesson repositories" do
      VCR.use_cassette "coderdojosf/Particles/lesson.json import" do
        organization = Organization.new("coderdojosf")
        importer = LessonImporter.new(organization)

        assert_equal 0, Lesson.count
        importer.import
        assert_equal 1, Lesson.count

        lesson = Lesson.first
        assert_equal "Animations in Javascript", lesson.title
        assert_equal "Build animations in the web browser using javascript and the D3.js library.", lesson.summary
        assert_equal "Particles", lesson.repository
      end
    end

    it "does not duplicate lesson repositories" do
      VCR.use_cassette "coderdojosf/Particles/lesson.json import twice" do
        organization = Organization.new("coderdojosf")
        importer = LessonImporter.new(organization)

        importer.import
        assert_equal 1, Lesson.count
        importer.import
        assert_equal 1, Lesson.count
      end
    end

    it "only returns lessons that were imported" do
      VCR.use_cassette "coderdojosf/Particles/lesson.json import twice" do
        organization = Organization.new("coderdojosf")
        importer = LessonImporter.new(organization)

        Lesson.any_instance.stubs(:changed?).returns(false)
        assert_equal [], importer.import
      end
    end
  end
end