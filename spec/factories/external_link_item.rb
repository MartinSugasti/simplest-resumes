# frozen_string_literal: true

FactoryBot.define do
  factory :external_link_item do
    resume
    name { 'LinkedIn' }
    url { 'https://linkedin.com/in/example' }
  end
end
