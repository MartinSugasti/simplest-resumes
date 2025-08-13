# frozen_string_literal: true

class OpenAi::CandidatesSqlService < OpenAi::NaturalLanguageToSqlService
  private

  def schema_description
    <<~PROMPT
      Database Schema:
      - candidates:
        - id (bigint, primary key)
        - email (string)
      - resumes:
        - id (bigint, primary key)
        - name (string)
        - location (string)
        - about_me (string)
        - candidate_id (bigint, foreign key)
      - education_items:
        - id (bigint, primary key)
        - name (string)
        - institute (string)
        - start_year (integer)
        - end_year (integer)
        - resume_id (bigint, foreign key)
      - work_experience_items:
        - id (bigint, primary key)
        - position (string)
        - company (string)
        - start_month (integer)
        - start_year (integer)
        - end_month (integer)
        - end_year (integer)
        - location (string)
        - description (string)
        - resume_id (bigint, foreign key)
      - skill_items:
        - id (bigint, primary key)
        - name (string)
        - kind (integer, enum: primary, secondary)
        - resume_id (bigint, foreign key)
      - reference_items:
        - id (bigint, primary key)
        - kind (integer, enum: personal, job)
        - name (string)
        - mobile (string)
        - company (string)
        - position (string)
        - resume_id (bigint, foreign key)
      - external_link_items:
        - id (bigint, primary key)
        - name (string)
        - url (string)
        - resume_id (bigint, foreign key)

      Relationships:
        - candidates has_one resume
        - resumes belongs_to candidate
        - resumes has_many education_items, work_experience_items, skill_items, reference_items, external_link_items
    PROMPT
  end

  def validation_examples
    <<~PROMPT
      Example 1:
        - User's query:
          Show me candidates with experience in marketing
        - Response:
          true

      Example 2:
        - User's query:
          Candidates that have worked at JP Morgan or similar companies
        - Response:
          true

      Example 3:
        - User's query:
          What is the average salary of candidates?
        - Response:
          false

      Example 4:
        - User's query:
          Show me candidates younger than 30 years old
        - Response:
          false
    PROMPT
  end

  def synonyms_rules
    <<~PROMPT
      - Use the following English synonyms:
        - Candidates: applicants, proffesionals, people, hires, talent, etc.
        - Resumes: CV, curriculum vitae, profile, bio, summary, career, etc.
        - Skills: abilities, competencies, knowledge, strengths, qualifications, etc.
      - Use the following Spanish synonyms:
        - Candidatos: aplicante, aspirante, aplicante, interesado, empleado, etc.
        - Resumes: CV, curriculum vitae, perfil, biografia, resumen, carrera, etc.
        - Skills: habilidades, competencias, conocimientos, fortalezas, cualidades, etc.
    PROMPT
  end

  def conversion_examples
    <<~PROMPT
      Example 1:
        - Natural language query:
          Show me candidates with experience in marketing
        - SQL query:
          SELECT DISTINCT c.* FROM candidates c
          JOIN resumes r ON r.candidate_id = c.id
          LEFT JOIN work_experience_items w ON w.resume_id = r.id
          LEFT JOIN skill_items s ON s.resume_id = r.id
          WHERE w.position ILIKE ANY (ARRAY['%marketing%', '%digital marketing%', '%advertising%', '%brand management%'])
            OR w.company ILIKE ANY (ARRAY['%marketing%', '%advertising%'])
            OR w.description ILIKE ANY (ARRAY['%marketing%', '%digital marketing%', '%advertising%', '%brand management%'])
            OR s.name ILIKE ANY (ARRAY['%marketing%', '%digital marketing%', '%advertising%', '%brand management%'])
          LIMIT 50;

      Example 2:
        - Natural language query:
          Show me candidates that have worked at JP Morgan or similar companies
        - SQL query:
          SELECT DISTINCT c.*
          FROM candidates c
          JOIN resumes r ON r.candidate_id = c.id
          LEFT JOIN work_experience_items w ON w.resume_id = r.id
          WHERE w.company ILIKE ANY (ARRAY['%morgan%', '%chase bank%', '%bank of america%', '%jpm%', '%citigroup%', '%wells fargo%', '%bank%]);
    PROMPT
  end

  def conversion_rules; end
end
