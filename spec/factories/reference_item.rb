# frozen_string_literal: true

FactoryBot.define do
  factory :reference_item do
    resume
    name { 'Jane Doe' }
    mobile { '+1234567890' }
    company { 'Acme Inc' }
    position { 'Manager' }
    kind { :personal }

    trait :job do
      kind { :job }
    end
  end
end
