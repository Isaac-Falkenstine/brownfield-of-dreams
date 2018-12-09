require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :follower_id }
    it { should validate_presence_of :followed_id }
    it { should belong_to :follower }
    it { should belong_to :followed }
  end
end