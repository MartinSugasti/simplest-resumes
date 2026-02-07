# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Candidates::PostulationsMailer do
  let(:postulation) { create(:postulation, :approved) }

  describe '#postulation_approved' do
    let(:mail) { described_class.postulation_approved(postulation.id) }

    it 'sends to the candidate email' do
      expect(mail.to).to include(postulation.candidate.email)
    end

    it 'renders the subject' do
      expect(mail.subject).to be_present
    end

    it 'includes job posting title in body' do
      expect(mail.body.encoded).to include(postulation.job_posting.title)
    end
  end

  describe '#postulation_rejected' do
    let(:postulation_rejected) { create(:postulation, :rejected) }
    let(:mail) { described_class.postulation_rejected(postulation_rejected.id) }

    it 'sends to the candidate email' do
      expect(mail.to).to include(postulation_rejected.candidate.email)
    end

    it 'includes job posting title in body' do
      expect(mail.body.encoded).to include(postulation_rejected.job_posting.title)
    end
  end
end
