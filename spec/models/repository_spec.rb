require 'rails_helper'

describe Repository do
  before(:each) do
    params = {name: "Repo 1", url: "https://www.google.com"}
    @repo = Repository.new(params)
  end

  it "exists" do
    expect(@repo).to be_a(Repository)
  end

  it "has attributes" do
    expect(@repo.name).to eq("Repo 1")
    expect(@repo.url).to eq("https://www.google.com")
  end

end
