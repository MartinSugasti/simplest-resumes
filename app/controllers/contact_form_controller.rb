# frozen_string_literal: true

class ContactFormController < ApplicationController
  def create
    if Google::RecaptchaService.new(safe_params[:recaptcha]).verify
      ContactFormMailer.new_request(
        safe_params[:name], safe_params[:email], safe_params[:mobile], safe_params[:query]
      ).deliver_later

      render json: "Thanks for your request. We'll be in touch soon!"
    else
      render json: "Recaptcha couldn't be verified. Please, try again later.", status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:contact_form).permit(:name, :email, :mobile, :query, :recaptcha)
  end
end
