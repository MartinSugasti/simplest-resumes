# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "admin#{n}@example.com" }
    password { 'password123' }
    role { :super_admin }
    confirmed_at { Time.current }

    trait :collaborator do
      role { :collaborator }
    end

    trait :unconfirmed do
      confirmed_at { nil }
    end
  end
end
