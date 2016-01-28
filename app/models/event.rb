class Event < ActiveRecord::Base
  attr_accessor :start_date, :start_time


  before_validation :set_start_date_time

  has_many :memberships
  has_many :users, through: :memberships
  has_many :comments
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true

  mount_uploader :picture, EventUploader

  include PgSearch
  pg_search_scope :search, against: [:title, :description, :address, :city, :state], using: {tsearch: {dictionary: "english"}}, associated_against: {comments: :body}

  def set_start_date_time
    self.starts_at = Time.zone.parse("#{start_date} #{start_time}")
  end

  def self.text_seach(query)
    search(query)
  end

  # scope :upcoming, -> { where("events.starts_at >= ?", Time.now) }

end
