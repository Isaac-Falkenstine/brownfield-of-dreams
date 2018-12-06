class GithubUser

  attr_reader :login,
              :url

  def initialize(data)
    @login   = data[:login]
    @url     = data[:url]
  end

end