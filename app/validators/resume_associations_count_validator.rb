# frozen_string_literal: true

class ResumeAssociationsCountValidator < ActiveModel::Validator
  def validate(record)
    association_table = record.class.table_name
    association_name = if ['skill_items', 'reference_items'].include?(association_table)
                         "#{record.kind}_#{association_table}"
                       else
                         association_table
                       end

    max_associations = Resume.validators_on(association_name)[0].options[:maximum]
    return if record.resume.send(association_name).count <= max_associations

    record.errors.add(
      :base,
      I18n.t(
        'activerecord.errors.validators.resume_associations_count_validator.too_many_associations',
        model_name: Resume.model_name.human,
        count: max_associations
      )
    )
  end
end
