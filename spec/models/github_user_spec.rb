require 'rails_helper'

describe GithubUser do
  before(:each) do
    @user = create(:user)
    params = {login: "Follower 1", 
              url: "https://www.google.com", 
              github_id: 123}
    @follower = GithubUser.new(params)
  end

  it "exists" do
    expect(@follower).to be_a(GithubUser)
  end

  it "has attributes" do
    expect(@follower.login).to eq("Follower 1")
    expect(@follower.url).to eq("https://www.google.com")
    expect(@follower.github_id).to eq(123)
    expect(@follower.user_id).to be_nil
  end

end
