require "minitest_helper"

describe LessonImporter do
  describe "#import" do
    it "creates lessons for lesson repositories" do
      VCR.use_cassette "coderdojosf/Particles/lesson.json import" do
        organization = Organization.new("coderdojosf")
        importer = LessonImporter.new(organization)

        assert_equal 0, Lesson.count
        importer.import
        assert_equal 2, Lesson.count

        lesson = Lesson.first
        assert_equal "Around the World", lesson.title
        assert_equal "An introduction to CSS3 animation effects", lesson.summary
        assert_equal "AroundTheWorld", lesson.repository
      end
    end

    it "does not duplicate lesson repositories" do
      VCR.use_cassette "coderdojosf/Particles/lesson.json import twice" do
        organization = Organization.new("coderdojosf")
        importer = LessonImporter.new(organization)

        first_import = importer.import
        assert_equal 2, Lesson.count
        assert_equal Lesson, first_import.first.class
        second_import = importer.import
        assert_equal 2, Lesson.count
        assert second_import.empty?
      end
    end

    it "only returns lessons that were imported" do
      VCR.use_cassette "coderdojosf/Particles/lesson.json import twice again" do
        organization = Organization.new("coderdojosf")
        importer = LessonImporter.new(organization)

        Lesson.any_instance.stubs(:changed?).returns(false)
        assert_equal [], importer.import
      end
    end
  end
end
