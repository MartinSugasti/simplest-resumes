# frozen_string_literal: true

FactoryBot.define do
  factory :resume do
    candidate
    name { 'John Doe' }
    email { 'john@example.com' }
    mobile { '+1234567890' }
    location { 'New York' }
    about_me { 'Experienced developer' }
  end
end
