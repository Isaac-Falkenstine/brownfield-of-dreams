class UserDashboardFacade

  def initialize(user)
    @user = user
  end

  def token
    @user.token
  end

  def repositories
    @repositories ||= repository_fetch_result.map do |repo_data|
      Repository.new(name: repo_data[:name], url: repo_data[:html_url])
    end.first(5)
  end

  private

  attr_reader :user

  def repository_fetch_result
    @repository_fetch_result ||= service.repos_json
  end

  def service
    GithubService.new(user.token)
  end
end