class UserDashboardFacade

  def initialize(user)
    @user = user
  end

  def token
    user.token
  end

  def repositories
    @repositories ||= repository_fetch_result.map do |repo_data|
      Repository.new(name: repo_data[:name], url: repo_data[:html_url])
    end.first(5)
  end

  def following
    @following ||= following_fetch_result.map do |user_data|
      GithubUser.new(login: user_data[:login], url: user_data[:html_url])
    end
  end

  def followers
    @followers ||= follower_fetch_result.map do |follower_data|
      GithubUser.new(login: follower_data[:login], url: follower_data[:html_url])
    end
  end

  def first_name
    user.first_name
  end

  def last_name
    user.last_name
  end

  def email
    user.email
  end

  private

  attr_reader :user

  def repository_fetch_result
    @repository_fetch_result ||= service.repos_json
  end

  def follower_fetch_result
    @follower_fetch_result ||= service.followers_json
  end
  
  def following_fetch_result
    @following_fetch_result ||= service.following_json
  end

  def service
    GithubService.new(user.token)
  end
end
