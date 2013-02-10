class User < ActiveRecord::Base
  attr_accessible :name, :github_id, :github_identifier, :email

  def self.find_for_github_oauth(access_token)
    return false unless access_token.credentials.team_member?

    info = access_token['info'] || access_token['extra'] && access_token['extra']['info']
    github_id = access_token['uid']
    user = find_or_initialize_by_github_id(github_id)

    if user.new_record?
      user.authentication_token = access_token['credentials']['token']
      user.name = info.name
      user.email = info.email
      user.github_identifier = info.nickname
      user.save!
    end

    user
  end
end
