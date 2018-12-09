class GithubUser

  attr_reader :user_id,
              :github_id,
              :login,
              :url

  def initialize(data)
    @user_id    = data[:user_id]
    @github_id  = data[:github_id]
    @login      = data[:login]
    @url        = data[:url]
  end

end