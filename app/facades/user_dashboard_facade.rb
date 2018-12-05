class UserDashboardFacade
  def repos
    repo_array.first(5)
  end

  def repo_array
    search_result.map do |repo_data|
      Repository.new({name: repo_data[:name], url: repo_data[:html_url]})
    end
  end

  private

  def search_result
    @search_result ||= service.repos_json
  end

  def service
    GithubService.new
  end
end
