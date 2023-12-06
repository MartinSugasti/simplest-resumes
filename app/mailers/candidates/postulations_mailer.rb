# frozen_string_literal: true

class Candidates::PostulationsMailer < ApplicationMailer
  default from: email_address_with_name('notifications@simplestresumes.com', I18n.t('mailers.from.notifications'))

  def postulation_approved(postulation_id)
    postulation = Postulation.find(postulation_id)
    candidate = postulation.candidate
    job_posting = postulation.job_posting

    I18n.with_locale(candidate.preferred_language) do
      mail(
        to: candidate.email,
        body: I18n.t('candidates.postulations_mailer.postulation_approved.body', job_posting_title: job_posting.title),
        content_type: "text/html"
      )
    end
  end

  def postulation_rejected(postulation_id)
    postulation = Postulation.find(postulation_id)
    candidate = postulation.candidate
    job_posting = postulation.job_posting

    I18n.with_locale(candidate.preferred_language) do
      mail(
        to: candidate.email,
        body: I18n.t('candidates.postulations_mailer.postulation_rejected.body', job_posting_title: job_posting.title),
        content_type: "text/html"
      )
    end
  end
end