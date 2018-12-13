require 'rails_helper'

RSpec.describe Tutorial, type: :model do

  describe 'Relationships' do
    it { should have_many :videos }
    it { should accept_nested_attributes_for :videos }
  end

end
