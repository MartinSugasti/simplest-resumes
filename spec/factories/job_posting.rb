# frozen_string_literal: true

FactoryBot.define do
  factory :job_posting do
    recruiter
    title { 'Software Engineer' }
    company { 'Acme Corp' }
    skills { 'Ruby, Rails' }
    description { 'Great job opportunity' }
    published { true }

    trait :unpublished do
      published { false }
    end
  end
end
