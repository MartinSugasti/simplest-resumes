# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recruiters::PostulationsController do
  let(:recruiter) { create(:recruiter) }
  let(:job_posting) { create(:job_posting, recruiter: recruiter) }
  let(:postulation) { create(:postulation, job_posting: job_posting) }

  before { sign_in recruiter }

  describe 'POST #approve' do
    it 'updates postulation status to approved' do
      post :approve, params: {
        job_posting_id: job_posting.id,
        postulation_id: postulation.id
      }

      expect(response).to have_http_status(:ok)
      expect(postulation.reload.status).to eq('approved')
    end

    it 'enqueues postulation approved mailer' do
      expect do
        post :approve, params: {
          job_posting_id: job_posting.id,
          postulation_id: postulation.id
        }
      end.to have_enqueued_job(ActionMailer::MailDeliveryJob)
    end
  end

  describe 'POST #reject' do
    it 'updates postulation status to rejected' do
      post :reject, params: {
        job_posting_id: job_posting.id,
        postulation_id: postulation.id
      }

      expect(response).to have_http_status(:ok)
      expect(postulation.reload.status).to eq('rejected')
    end

    it 'enqueues postulation rejected mailer' do
      expect do
        post :reject, params: {
          job_posting_id: job_posting.id,
          postulation_id: postulation.id
        }
      end.to have_enqueued_job(ActionMailer::MailDeliveryJob)
    end
  end
end
