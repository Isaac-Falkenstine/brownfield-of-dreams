class GithubUser

  attr_reader :id,
              :login,
              :url
              # :account_id

  def initialize(data)
    @login      = data[:login]
    @url        = data[:url]
    # @account_id = data[:account_id]
  end

end