class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :followers,  class_name: "Friendship", 
                        foreign_key: "follower_id",
                        dependent: :destroy
  has_many :users, through: :followers
  has_many :followings, class_name: "Friendship", 
                        foreign_key: "following_id",
                        dependent: :destroy
  has_many :users, through: :followings

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password
end
