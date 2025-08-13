# frozen_string_literal: true

class Candidates::JobPostingsController < ApplicationController
  before_action :authenticate_candidate!

  def index
    respond_to do |format|
      format.html
      format.json do
        if params[:query].present?
          openai_service = OpenAi::JobPostingsSqlService.new(params[:query])

          if openai_service.valid?
            openai_service.process

            if openai_service.safe?
              render json: JobPosting.find_by_sql(openai_service.sql_query)
            else
              render json: { errors: I18n.t('candidates.job_postings.errors.unable_to_process_query') },
                     status: :unprocessable_entity
            end
          else
            render json: { errors: I18n.t('candidates.job_postings.errors.query_not_valid') },
                   status: :unprocessable_entity
          end
        else
          render json: JobPosting.published
        end
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: JobPosting.published.find(params[:id]) }
    end
  end
end
