class UserDashboardFacade
  def repositories
    repo_array.first(5)
  end

  def repo_array
    repository_fetch_result.map do |repo_data|
      Repository.new(name: repo_data[:name], url: repo_data[:html_url])
    end
  end

  private

  def repository_fetch_result
    @repository_fetch_result ||= service.repos_json
  end

  def service
    GithubService.new #(user.token)
  end
end
