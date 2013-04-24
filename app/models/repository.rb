class Repository
  # Public: GitHub organization username passed in during initialization.
  attr_reader :username

  # Public: Lesson repository name passed in during initialization.
  attr_reader :name

  # Public: Called by .new while instantiating the object.
  #
  # username - GitHub organization username.
  # name - Lesson repository name.
  def initialize(username, name)
    @username = username
    @name = name
  end

  # Public: Determine if this is a lesson repository.
  #
  # Returns a TrueClass or FalseClass
  def lesson?
    GitHubApi.code(lesson_json_api_path) == 200
  end

  # Public: Return parsed lesson.json.
  #
  # Returns a Hash.
  def lesson
    GitHubApi.parsed_file_contents(lesson_json_api_path)
  end

  # Internal: GitHub API path to lesson.json for repository.
  #
  # Returns a String.
  def lesson_json_api_path
    "repos/#{username}/#{name}/contents/lesson.json"
  end
end