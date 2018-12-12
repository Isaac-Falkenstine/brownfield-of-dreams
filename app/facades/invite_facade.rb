class InviteFacade

  def initialize(user, recipient_login)
    @user = user
    @recipient_login = recipient_login
  end

  def valid_login?
    recipient.login ? true : false
  end

  def valid_email?
    recipient.email ? true : false
  end

  def sender
    user_data = sender_fetch_result(@user.github_login)
    @sender ||= create_github_user(user_data) 
  end
  
  def recipient
    user_data = recipient_fetch_result(@recipient_login)
    @recipient ||= create_github_user(user_data) 
  end

  def create_github_user(user_data)
    params = {login: user_data[:login],
              url: user_data[:html_url],
              github_id: user_data[:id],
                # user_id: nil,
              name: user_data[:name],
              email: user_data[:email]}
    params[:name] = user_data[:login] if !params[:name]
    GithubUser.new(params)
  end

  private

  attr_reader :user

  def sender_fetch_result(login)
    @sender_fetch_result ||= service.user_json(login)
  end

  def recipient_fetch_result(login)
    @recipient_fetch_result ||= service.user_json(login)
  end

  def service
    GithubService.new(user.token)
  end


end