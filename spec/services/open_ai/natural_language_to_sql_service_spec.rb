# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OpenAi::NaturalLanguageToSqlService do
  # Use concrete implementation that has schema_description, etc.
  let(:query) { 'How many candidates do we have?' }
  let(:service_class) { OpenAi::CandidatesSqlService }

  describe '#safe?' do
    it 'returns false when sql_query does not start with SELECT' do
      service = service_class.new(query)
      service.sql_query = 'INSERT INTO users VALUES (1)'
      expect(service.safe?).to be false
    end

    it 'returns false when sql_query contains dangerous keywords' do
      service = service_class.new(query)
      service.sql_query = 'SELECT * FROM users; DROP TABLE users;'
      expect(service.safe?).to be false
    end

    it 'returns true when sql_query is a safe SELECT statement' do
      service = service_class.new(query)
      service.sql_query = 'SELECT COUNT(*) FROM candidates'
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
      service = service_class.new(query)

      expect(service.valid?).to be true
    end
  end

  describe '#process' do
    it 'sets sql_query from OpenAI response' do
      client = instance_double(OpenAI::Client)
      allow(OpenAI::Client).to receive(:new).and_return(client)
      allow(client).to receive(:chat).and_return(
        { 'choices' => [{ 'message' => { 'content' => 'SELECT COUNT(*) FROM candidates' } }] }
      )
      service = service_class.new(query)

      service.process

      expect(service.sql_query).to eq('SELECT COUNT(*) FROM candidates')
    end
  end
end
