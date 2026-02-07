# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenAi::JobPostingsSqlService do
  let(:query) { 'Show me jobs postings that require experience with ruby on rails' }

  describe '#safe?' do
    it 'returns false when sql_query does not start with SELECT' do
      service = described_class.new(query)
      service.sql_query = 'DELETE FROM job_postings WHERE id = 1'
      expect(service.safe?).to be false
    end

    it 'returns false when sql_query contains dangerous keywords' do
      service = described_class.new(query)
      service.sql_query = 'SELECT * FROM job_postings; TRUNCATE job_postings;'
      expect(service.safe?).to be false
    end

    it 'returns true when sql_query is a safe SELECT statement for job_postings' do
      service = described_class.new(query)
      service.sql_query = 'SELECT DISTINCT * FROM job_postings WHERE published = true LIMIT 50'
      expect(service.safe?).to be true
    end
  end

  describe '#valid?' do
    it 'returns true when OpenAI responds with true' do
      client = instance_double(OpenAI::Client)
      allow(OpenAI::Client).to receive(:new).and_return(client)
      allow(client).to receive(:chat).and_return(
        { 'choices' => [{ 'message' => { 'content' => 'true' } }] }
      )
      service = described_class.new(query)

      expect(service.valid?).to be true
    end

    it 'returns false when OpenAI responds with false' do
      client = instance_double(OpenAI::Client)
      allow(OpenAI::Client).to receive(:new).and_return(client)
      allow(client).to receive(:chat).and_return(
        { 'choices' => [{ 'message' => { 'content' => 'false' } }] }
      )
      service = described_class.new('Job postings that pay more than $100,000')

      expect(service.valid?).to be false
    end
  end

  describe '#process' do
    it 'sets sql_query from OpenAI response' do
      expected_sql = 'SELECT DISTINCT * FROM job_postings WHERE published = true LIMIT 50'
      client = instance_double(OpenAI::Client)
      allow(OpenAI::Client).to receive(:new).and_return(client)
      allow(client).to receive(:chat).and_return(
        { 'choices' => [{ 'message' => { 'content' => expected_sql } }] }
      )
      service = described_class.new(query)

      service.process

      expect(service.sql_query).to eq(expected_sql)
    end
  end
end
