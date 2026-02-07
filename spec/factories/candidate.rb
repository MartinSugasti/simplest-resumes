# frozen_string_literal: true

FactoryBot.define do
  factory :candidate do
    sequence(:email) { |n| "candidate#{n}@example.com" }
    password { 'password123' }
    confirmed_at { Time.current }

    trait :with_subscription do
      subscription_ends_at { 1.month.from_now }
    end

    trait :without_subscription do
      subscription_ends_at { nil }
    end

    trait :unconfirmed do
      confirmed_at { nil }
    end
  end
end
