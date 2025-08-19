# frozen_string_literal: true

class OpenAi::JobPostingsSqlService < OpenAi::NaturalLanguageToSqlService
  private

  def schema_description
    <<~PROMPT
      Database Schema:
      - job_postings:
        - id (bigint, primary key)
        - title (string)
        - company (string)
        - skills (string)
        - description (string)
        - published (boolean)
        - created_at (datetime)
    PROMPT
  end

  def validation_examples
    <<~PROMPT
      Example 1:
        - User's query:
          Show me jobs postings that require experience with ruby on rails
        - Response:
          true

      Example 2:
        - User's query:
          Job postings published in the last 30 days
        - Response:
          true

      Example 3:
        - User's query:
          Job postings that pay more than $100,000
        - Response:
          false

      Example 4:
        - User's query:
          Jobs that only accepts men
        - Response:
          false
    PROMPT
  end

  def synonyms_rules
    <<~PROMPT
      - Use the following English synonyms:
        - Job Postings: job offers, opportunities, positions, announcements, postings, etc.
      - Use the following Spanish synonyms:
        - Anuncions De Empleo: ofertas, avisos, vacantes, posiciones, etc.
    PROMPT
  end

  def conversion_examples
    <<~PROMPT
      Example 1:
        - Natural language query:
          Show me jobs postings that require experience with ruby on rails
        - SQL query:
          SELECT DISTINCT * FROM job_postings
          WHERE skills ILIKE ANY (ARRAY['%ruby on rails%', '%ror%', '%rails%'])
            OR description ILIKE ANY (ARRAY['%ruby on rails%', '%ror%', '%rails%'])
          LIMIT 50;

      Example 2:
        - Natural language query:
          Job postings published in the last 30 days
        - SQL query:
          SELECT DISTINCT * FROM job_postings
          WHERE created_at >= NOW() - INTERVAL '30 days'
          LIMIT 50;

      Example 3:
        - Natural language query:
          Jobs postings from JP Morgan or similar companies
        - SQL query:
          SELECT DISTINCT * FROM job_postings
          WHERE company ILIKE ANY (ARRAY['%morgan%', '%chase bank%', '%bank of america%', '%jpm%', '%citigroup%', '%wells fargo%'])
            OR description ILIKE ANY (ARRAY['%morgan%', '%chase bank%', '%bank of america%', '%jpm%', '%citigroup%', '%wells fargo%'])
          LIMIT 50;
    PROMPT
  end

  def conversion_rules
    <<~PROMPT
      - Only inlcude job postings that are published
    PROMPT
  end
end
