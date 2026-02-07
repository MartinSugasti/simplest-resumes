# frozen_string_literal: true

FactoryBot.define do
  factory :education_item do
    resume
    name { 'Computer Science' }
    institute { 'MIT' }
    start_year { 2018 }
    end_year { 2022 }
  end
end
