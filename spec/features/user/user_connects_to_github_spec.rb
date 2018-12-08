require "rails_helper"

describe "User connects to GitHub" do

  before do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]
    stub_request(:get, "https://api.github.com/user/repos").
      to_return(body: File.read("./spec/fixtures/github_repos.json"))
    stub_request(:get, "https://api.github.com/user/followers").
      to_return(body: File.read("./spec/fixtures/github_followers.json"))
    stub_request(:get, "https://api.github.com/user/following").
      to_return(body: File.read("./spec/fixtures/github_following.json"))
  end
  
  it "should return a GitHub access token when authenticated" do

    user = create(:user)

    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"
    visit dashboard_path
    expect(user.token).to be_nil
    
    click_on "Connect to GitHub"
    
    expect(current_path).to eq(dashboard_path)
    expect(User.first.token).to eq("token 123456789")

  end

  it "should not return a GitHub access token when authentication fails" do

    OmniAuth.config.mock_auth[:github] = :invalid_credentials
    OmniAuth.config.on_failure = Proc.new { |env|
      OmniAuth::FailureEndpoint.new(env).redirect_to_failure
    }

    user = create(:user)

    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"
    visit dashboard_path
    expect(user.token).to be_nil
    
    click_on "Connect to GitHub"
    
    expect(current_path).to eq(dashboard_path)
    expect(User.first.token).to be_nil

  end
end