class Repository
  attr_reader :name, :organization_name

  # Public: Called by .new while instantiating the object.
  #
  # attributes - repository attributes.
  def initialize(organization_name, name)
    @organization_name = organization_name
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
    GitHubApi.parsed_response(lesson_json_api_path)
  end

  # Internal: GitHub API path to lesson.json for repository.
  #
  # Returns a String.
  def lesson_json_api_path
    "repos/#{organization_name}/#{name}/contents/lesson.json"
  end
end