# frozen_string_literal: true

class OpenAi::NaturalLanguageToSqlService
  SAFE_STATEMENTS = /\ASELECT\b/i
  ALLOWED_KEYWORDS = %w[
    SELECT FROM WHERE JOIN LEFT RIGHT INNER OUTER ON GROUP BY HAVING
    ORDER LIMIT OFFSET ILIKE LIKE ANY ARRAY AND OR NOT DISTINCT AS
    COUNT MIN MAX AVG SUM LOWER UPPER CAST IN IS NULL TRUE FALSE
  ].freeze

  attr_reader :query, :client
  attr_accessor :sql_query

  def initialize(query)
    @query = query
    @client = OpenAI::Client.new
  end

  # TODO: Combine valid? and to_sql into a single call to openAI
  def valid?
    response = chat(validation_prompt, query)
    response.dig('choices', 0, 'message', 'content') == 'true'
  rescue StandardError => e
    Honeybadger.notify(e)
    false
  end

  def process
    response = chat(conversion_prompt, query)
    @sql_query = response.dig('choices', 0, 'message', 'content')
  rescue StandardError => e
    Honeybadger.notify(e)
  end

  def safe?
    # Must start with SELECT
    return false unless sql_query.match?(SAFE_STATEMENTS)

    # Disallow dangerous keywords
    return false if sql_query.match?(/\b(INSERT|UPDATE|DELETE|DROP|ALTER|TRUNCATE)\b/i)

    # Whitelist only allowed keywords
    tokens = sql_query.scan(/\b[A-Z_]+\b/).uniq
    disallowed = tokens - ALLOWED_KEYWORDS
    return false if disallowed.any?

    true
  end

  private

  def chat(prompt, query)
    client.chat(
      parameters: {
        model: 'gpt-4o',
        messages: [
          { role: 'system', content: prompt },
          { role: 'user', content: query }
        ],
        temperature: 0.1
      }
    )
  end

  def validation_prompt
    <<~PROMPT
      You are a database assistant. Your task is to determine whether a user's query can be answered using ONLY the database schema provided.

      Rules:
      - Answer only "true" or "false"
      - "true" if the query can be answered with the schema provided
      - "false" if the query is unrelated or requires data not in the schema
      - Never include explanations
      - User's query may be in Spanish, so you must translate it to English before converting it to SQL
      #{synonyms_rules}

      #{schema_description}

      #{validation_examples}

      User's query:
    PROMPT
  end

  def conversion_prompt
    <<~PROMPT
      You are a SQL expert. Convert natural language queries to PostgreSQL SQL queries.

      Rules:
      - Use only the tables and columns listed below
      - If a query requires joining tables always ensure results are deduplicated by using SELECT DISTINCT
      - SQL statements must be in uppercase, but table and column names should be in lowercase
      - Never invent table names or columns
      - Use table aliases where appropriate
      - Prefer INNER JOIN when matching related tables
      - Only return the SQL query, no explanations
      - Use appropriate WHERE clauses for filtering
      - Return SELECT queries only (no INSERT, UPDATE, DELETE, DROP, ALTER, TRUNCATE)
      - Only respond with the SQL query and nothing else. Do not include any formatting, code blocks or line breaks
      - Use LIMIT 50 unless the user specifies otherwise
      - Use synonyms or related words for skills, work experience, education, skill_items, etc.
      - User's query may be in Spanish, so you must translate it to English before converting it to SQL
      #{synonyms_rules}
      #{conversion_rules}

      #{schema_description}

      #{conversion_examples}

      Now, translate this query into SQL:
    PROMPT
  end
end
