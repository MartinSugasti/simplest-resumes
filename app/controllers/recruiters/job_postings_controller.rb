# frozen_string_literal: true

class Recruiters::JobPostingsController < ApplicationController
  before_action :authenticate_recruiter!

  def index
    respond_to do |format|
      format.html
      format.json { render json: current_recruiter.job_postings }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json do
        job_posting = JobPosting.find(params[:id])
        authorize(job_posting, policy_class: Recruiters::JobPostingPolicy)

        render json: job_posting, include: ['postulations', 'postulations.candidate']
      end
    end
  end

  def new; end

  def create
    job_posting = current_recruiter.job_postings.build(safe_params)
    authorize(job_posting, policy_class: Recruiters::JobPostingPolicy)

    if job_posting.save
      head :ok
    else
      render json: { errors: job_posting.errors }, status: :unprocessable_entity
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.json do
        job_posting = JobPosting.find(params[:id])
        authorize(job_posting, policy_class: Recruiters::JobPostingPolicy)

        render json: job_posting
      end
    end
  end

  def update
    job_posting = JobPosting.find(params[:id])
    authorize(job_posting, policy_class: Recruiters::JobPostingPolicy)

    if job_posting.update(safe_params)
      head :ok
    else
      render json: { errors: job_posting.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    job_posting = JobPosting.find(params[:id])
    authorize(job_posting, policy_class: Recruiters::JobPostingPolicy)

    if job_posting.destroy
      head :ok
    else
      render json: { errors: job_posting.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:job_posting).permit(:title, :company, :skills, :description, :published)
  end
end
