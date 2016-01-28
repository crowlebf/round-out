class User < ActiveRecord::Base
  geocoded_by :current_sign_in_ip
  after_validation :geocode
  include PgSearch
  has_many :memberships
  has_many :joined_events, through: :memberships, class_name: "Event"
  has_many :events
  has_many :comments
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  devise(
          :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
        )

  mount_uploader :avatar, AvatarUploader

  def creator?(event)
    event.user_id == id
  end
end
