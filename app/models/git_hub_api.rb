class GitHubApi
  # Public: Get resource from GitHub API.
  #
  # path - path to resource in the API.
  #
  # Returns an Array or Hash.
  def self.api_call(path)
    response = HTTParty.get("#{base_url}/#{path}", {
      headers: {
        "User-Agent" => user_agent
      }
    })
    ActiveSupport::JSON.decode(response.body)
  end

  # Public: Get response status code for path.
  #
  # path - path to resource in the API.
  #
  # Returns an Integer.
  def self.code(path)
    response = HTTParty.get("#{base_url}/#{path}", {
      headers: {
        "User-Agent" => user_agent
      }
    })
    response.code
  end

  # Public: Get parsed file contents from the GitHub API.
  #
  # path - path to resource in the API.
  #
  # Returns an Array or Hash.
  def self.parsed_file_contents(path)
    response = HTTParty.get("#{base_url}/#{path}", {
      headers: {
        "accept" => "application/vnd.github-blob.raw",
        "User-Agent" => user_agent
      }
    })
    # ActiveSupport::JSON.decode(response.body)
    # FIX: Don't use YAML.load here. Only used because
    # ActiveSupport::JSON was choking.
    YAML.load(response.body)
  end

  def self.user_agent
    ENV["GITHUB_ORGANIZATION"]
  end

  # Internal: Base url to GitHub API.
  #
  # Returns a String.
  def self.base_url
    "https://api.github.com"
  end
end
