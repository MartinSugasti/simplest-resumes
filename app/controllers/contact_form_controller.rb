# frozen_string_literal: true

class ContactFormController < ApplicationController
  def create
    if Google::RecaptchaService.new(safe_params[:recaptcha]).verify
      ContactFormMailer.new_request(
        safe_params[:name], safe_params[:email], safe_params[:mobile], safe_params[:query]
      ).deliver_later

      render json: t('.notice')
    else
      render json: t('.failure'), status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:contact_form).permit(:name, :email, :mobile, :query, :recaptcha)
  end
end
