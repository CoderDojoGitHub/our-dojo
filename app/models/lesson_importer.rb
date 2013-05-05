class LessonImporter
  # Public: Organization passed in during initialization.
  attr_reader :organization

  # Public: Called by .new while instantiating the object.
  #
  # organization = Organization object to import from.
  def initialize(organization)
    @organization = organization
  end

  # Public: Import lessons from lesson repositories in the organization.
  #
  # Returns an Array.
  def import
    lesson_repositories.map do |lesson_repository|
      lesson_attributes = lesson_repository.lesson
      lesson = Lesson.find_or_initialize_by_repository(lesson_repository.name)
      lesson.title = lesson_attributes["title"]
      lesson.summary = lesson_attributes["summary"]
      lesson.image_url = lesson_attributes["image_url"]
      lesson.author_github_username = lesson_attributes["author_github_username"]
      lesson.events_attributes = lesson_attributes["events"]
      if lesson.changed?
        lesson.save
        lesson
      end
    end.compact
  end

  # Public: Grab the lesson_repositories from the organization.
  #
  # Returns an Array.
  def lesson_repositories
    @lesson_repositories ||= organization.lesson_repositories
  end
end
