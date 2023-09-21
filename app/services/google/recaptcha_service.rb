# frozen_string_literal: true

class Google::RecaptchaService
  GOOGLE_RECAPTCHA_SECRET_KEY = Rails.configuration.google_recaptcha_secret_key

  def initialize(token)
    @token = token
  end

  def verify
    uri = URI.parse(
      "https://www.google.com/recaptcha/api/siteverify?secret=#{GOOGLE_RECAPTCHA_SECRET_KEY}&response=#{@token}"
    )
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)

    json['success']
  end
end