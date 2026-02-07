# frozen_string_literal: true

FactoryBot.define do
  factory :skill_item do
    resume
    name { 'Ruby' }
    kind { :primary }

    trait :secondary do
      kind { :secondary }
    end
  end
end
