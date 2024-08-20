# frozen_string_literal: true

# == Schema Information
#
# Table name: resumes
#
#  id           :bigint           not null, primary key
#  about_me     :text
#  email        :string(40)
#  location     :string(40)
#  mobile       :string(20)
#  name         :string(40)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  candidate_id :bigint           not null
#
# Indexes
#
#  index_resumes_on_candidate_id  (candidate_id)
#
# Foreign Keys
#
#  fk_rails_...  (candidate_id => candidates.id)
#
class Resume < ApplicationRecord
  belongs_to :candidate

  has_many :education_items, dependent: :destroy
  validates :education_items, length: { maximum: 5 }

  has_many :work_experience_items, dependent: :destroy
  validates :work_experience_items, length: { maximum: 5 }

  has_many :primary_skill_items,
           -> { where(kind: :primary) },
           class_name: 'SkillItem',
           inverse_of: :resume,
           dependent: :destroy
  validates :primary_skill_items, length: { maximum: 5 }

  has_many :secondary_skill_items,
           -> { where(kind: :secondary) },
           class_name: 'SkillItem',
           inverse_of: :resume,
           dependent: :destroy
  validates :secondary_skill_items, length: { maximum: 5 }

  has_many :personal_reference_items,
           -> { where(kind: :personal) },
           class_name: 'ReferenceItem',
           inverse_of: :resume,
           dependent: :destroy
  validates :personal_reference_items, length: { maximum: 4 }

  has_many :job_reference_items,
           -> { where(kind: :job) },
           class_name: 'ReferenceItem',
           inverse_of: :resume,
           dependent: :destroy
  validates :job_reference_items, length: { maximum: 4 }

  has_many :external_link_items, dependent: :destroy
  validates :external_link_items, length: { maximum: 5 }

  validates :name, length: { maximum: 40 }
  validates :email, length: { maximum: 40 }, format: Devise.email_regexp, allow_blank: true
  validates :mobile, length: { maximum: 20 }
  validates :location, length: { maximum: 40 }
  validates :about_me, length: { maximum: 800 }
end
