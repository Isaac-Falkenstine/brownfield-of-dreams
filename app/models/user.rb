class User < ApplicationRecord
  before_create :confirmation_token

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
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def confirmation_token
    if self.status_token.blank?
      self.status_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
