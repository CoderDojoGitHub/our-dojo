class Organization
  attr_reader :username

  # Public: Called by .new while instantiating the object.
  #
  # username - Organization username on GitHub.
  def initialize(username)
    @username = username
  end

  # Public: Returns repository information retrieved from the GitHub
  # API using the Octokit library.
  #
  # Returns an Array.
  def repositories
    data = GitHubApi.parsed_response("users/coderdojosf/repos")
    data.map {|attributes| Repository.new(username, attributes["name"]) }
  end

  # Public: Returns an array of repositories that are lessons.
  #
  # Returns an Array.
  def lesson_repositories
    repositories.select(&:lesson?)
  end
end