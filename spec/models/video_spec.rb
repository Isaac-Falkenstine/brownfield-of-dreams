require 'rails_helper'

describe Video, type: :model do
  describe 'Validations' do
      it { should validate_presence_of :position }
  end
end

