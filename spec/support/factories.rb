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
