class Event < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  validates :starts_at, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
end
