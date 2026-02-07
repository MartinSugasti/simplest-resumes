# frozen_string_literal: true

FactoryBot.define do
  factory :invitation_request do
    sequence(:email) { |n| "invite#{n}@example.com" }
    status { :pending }

    trait :approved do
      status { :approved }
    end

    trait :dismissed do
      status { :dismissed }
    end

    trait :banned do
      status { :banned }
    end
  end
end
