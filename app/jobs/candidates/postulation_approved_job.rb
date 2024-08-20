# frozen_string_literal: true

class Candidates::PostulationApprovedJob < ApplicationJob
  queue_as :default

  def perform(postulation_id)
    postulation = Postulation.find(postulation_id)
    job_posting = postulation.job_posting

    I18n.with_locale(:es) do
      Rails.logger.info(
        'Checking if translation is taken into account: ' \
        "#{I18n.t('candidates.postulation_approved_job.sms_message', job_posting_title: job_posting.title)}"
      )

      Twilio::SmsService.new(
        I18n.t('candidates.postulation_approved_job.sms_message', job_posting_title: job_posting.title),
        '+1111111111' # Add mobile number to candidates for using their real phone number
      ).call
    end
  end
end
