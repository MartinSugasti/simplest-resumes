# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenAi::CandidatesSqlService do
  let(:query) { 'Show me candidates with experience in marketing' }

  describe '#safe?' do
    it 'returns false when sql_query does not start with SELECT' do
      service = described_class.new(query)
      service.sql_query = 'INSERT INTO candidates VALUES (1)'
      expect(service.safe?).to be false
    end

    it 'returns false when sql_query contains dangerous keywords' do
      service = described_class.new(query)
      service.sql_query = 'SELECT * FROM candidates; DROP TABLE candidates;'
      expect(service.safe?).to be false
    end

    it 'returns true when sql_query is a safe SELECT statement for candidates' do
      service = described_class.new(query)
      service.sql_query = 'SELECT DISTINCT c.* FROM candidates c JOIN resumes r ON r.candidate_id = c.id LIMIT 50'
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
      service = described_class.new('What is the average salary of candidates?')

      expect(service.valid?).to be false
    end
  end

  describe '#process' do
    it 'sets sql_query from OpenAI response' do
      expected_sql = 'SELECT DISTINCT c.* FROM candidates c JOIN resumes r ON r.candidate_id = c.id LIMIT 50'
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
