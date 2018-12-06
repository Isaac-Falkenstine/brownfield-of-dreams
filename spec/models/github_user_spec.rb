require 'rails_helper'

describe GithubUser do
  before(:each) do
    params = {login: "Follower 1", url: "https://www.google.com"}
    @follower = GithubUser.new(params)
  end

  it "exists" do
    expect(@follower).to be_a(GithubUser)
  end

  it "has attributes" do
    expect(@follower.login).to eq("Follower 1")
    expect(@follower.url).to eq("https://www.google.com")
  end

end
