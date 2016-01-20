require 'rails_helper'

FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "Brian#{n}" }
    sequence(:last_name) { |n| "Crowley#{n}" }
    sequence(:email) { |n| "crowlebf#{n}@user.com" }
    password 'password'
    password_confirmation 'password'
  end
end

FactoryGirl.define do
  factory :event do
    sequence(:title) { |n| "Book Club#{n}" }
    sequence(:description) { |n| "Looking for 3 to join our bookclub#{n}" }
    sequence(:starts_at) { |n| "2016-01-20 21:00:0#{n} UTC" }
    sequence(:address) { |n| "123 Main Street#{n}" }
    sequence(:city) { |n| "Austin#{n}" }
    sequence(:state) { |n| "TX#{n}" }
  end
end
