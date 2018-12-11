class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  has_many :followers,  class_name: "Friendship", 
                        foreign_key: "follower_id",
                        dependent: :destroy
  has_many :followeds,  class_name: "Friendship", 
                        foreign_key: "followed_id",
                        dependent: :destroy
  has_many :friends, through: :followers, source: :followed
                        
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, on: :create
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password
end
