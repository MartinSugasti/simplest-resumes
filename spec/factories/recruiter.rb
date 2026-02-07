# frozen_string_literal: true

FactoryBot.define do
  factory :recruiter do
    sequence(:email) { |n| "recruiter#{n}@example.com" }
    password { 'password123' }
    confirmed_at { Time.current }

    trait :unconfirmed do
      confirmed_at { nil }
    end
  end
end
