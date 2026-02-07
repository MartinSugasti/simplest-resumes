# frozen_string_literal: true

FactoryBot.define do
  factory :postulation do
    candidate
    job_posting
    status { :pending }

    trait :approved do
      status { :approved }
    end

    trait :rejected do
      status { :rejected }
    end
  end
end
