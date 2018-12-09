require 'rails_helper'

describe 'Validations' do
  it { should validate_presence_of :follower_id }
  it { should validate_presence_of :following_id }
  it { should belong_to :users }
end