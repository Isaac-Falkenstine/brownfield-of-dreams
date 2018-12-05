class UserDashboardFacade
  def repos
    binding.pry
  end
  def member_count
    members.count
  end

  def members
    search_result[:results].map do |member_data|
      Member.new(member_data)
    end
  end

  def copyright
    search_result[:copyright]
  end

  private

  def search_result
    @_search_result ||= service.members_of_house
  end

  def service
    GithubService.new
  end
end
