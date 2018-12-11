class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  validates_presence_of :position

  def self.assign_nil_position
    videos = Video.where(position: nil)
    videos.each do |video|
      tutorial = Tutorial.find(video.tutorial_id)
      video.update_attribute(:position, tutorial.videos.maximum(:position) + 1)
    end
  end
end
