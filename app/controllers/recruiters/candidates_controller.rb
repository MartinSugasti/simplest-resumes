# frozen_string_literal: true

class Recruiters::CandidatesController < ApplicationController
  before_action :authenticate_recruiter!

  def index
    respond_to do |format|
      format.html
      format.json do
        if params[:query].present?
          openai_service = OpenAi::CandidatesSqlService.new(params[:query])

          if openai_service.valid?
            openai_service.process

            if openai_service.safe?
              render json: Candidate.find_by_sql(openai_service.sql_query)
            else
              render json: { errors: I18n.t('recruiters.candidates.errors.unable_to_process_query') },
                     status: :unprocessable_entity
            end
          else
            render json: { errors: I18n.t('recruiters.candidates.errors.query_not_valid') },
                   status: :unprocessable_entity
          end
        else
          render json: Candidate.confirmed.order(:id)
        end
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: Candidate.confirmed.find(params[:id]) }
    end
  end
end
