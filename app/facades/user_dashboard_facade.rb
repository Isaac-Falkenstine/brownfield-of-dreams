class UserDashboardFacade

  def initialize(user)
    @user = user
  end

  def token
    user.token
  end

  def repositories
    @repositories ||= repository_fetch_result.map do |repo_data|
      params = {name: repo_data[:name], url: repo_data[:html_url]}
      Repository.new(params)
    end.first(5)
  end

  def following
    @following ||= following_fetch_result.map do |user_data|
      create_github_user(user_data)
    end
  end

  def followers
    @followers ||= follower_fetch_result.map do |user_data|
      create_github_user(user_data)
    end
  end

  def create_github_user(user_data)
    params = {login: user_data[:login], 
              url: user_data[:html_url],
              github_id: user_data[:id],
              user_id: github_user_account(user_data[:id])}
    GithubUser.new(params)
  end

  def friends
    user.friends.to_a
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

  def id
    user.id
  end

  def github_user_account(github_id)
    user = User.find_by(github_id: github_id)
    user ? user.id : nil
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
