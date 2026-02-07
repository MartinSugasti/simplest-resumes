# frozen_string_literal: true

FactoryBot.define do
  factory :work_experience_item do
    resume
    position { 'Software Developer' }
    company { 'Tech Corp' }
    location { 'San Francisco' }
    description { 'Developed amazing features' }
    start_month { 1 }
    start_year { 2020 }
  end
end
