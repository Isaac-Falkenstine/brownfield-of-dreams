require 'rails_helper'

describe Video, type: :model do
  describe 'Validations' do
      it { should validate_presence_of :position }
  end

  describe 'Methods' do
    it 'should assign all nil position values to max plus one' do
      tutorial = create(:tutorial)
      video_1 = create(:video, tutorial: tutorial, position: 1)
      video_2 = create(:video, tutorial: tutorial, position: 2)
      video_3 = create(:video, tutorial: tutorial)
      video_3.update_attribute(:position, nil)
      Video.assign_nil_position

      all_positions = Video.pluck(:position)

      expect(all_positions).to eq([1, 2, 3])
    end
  end
end

