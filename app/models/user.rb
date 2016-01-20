class User < ActiveRecord::Base
  has_many :memberships
  has_many :joined_events, through: :memberships, class_name: "Event"
  has_many :events
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  devise(
          :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
        )
        
  def creator?(event)
    event.user_id == id
  end
end
