# frozen_string_literal: true

class Twilio::SmsService
  TWILIO_ACCOUNT_SID = Rails.configuration.twilio_account_sid
  TWILIO_AUTH_TOKEN = Rails.configuration.twilio_auth_token
  TWILIO_FROM_PHONE = Rails.configuration.twilio_from_phone
  TWILIO_TEST_PHONE = Rails.configuration.twilio_test_phone

  def initialize(body, to_phone_number)
    @body = body
    @to = to(to_phone_number)
  end

  def call
    @client = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)

    message = @client.messages.create(
                body: @body,
                from: TWILIO_FROM_PHONE,
                to: @to
              )
    puts message.sid
  end

  private

  # Uncomment once the Twilio account is upgraded, so that messages can be send not only to
  # verified numbers, like TWILIO_TEST_PHONE
  def to(to_phone_number)
    # return TWILIO_TEST_PHONE if Rails.env.development?

    # to_phone_number
    TWILIO_TEST_PHONE
  end
end
