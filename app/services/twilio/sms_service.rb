# frozen_string_literal: true

class Twilio::SmsService
  TWILIO_ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID']
  TWILIO_AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN']
  TWILIO_FROM_PHONE = ENV['TWILIO_FROM_PHONE']
  TWILIO_TEST_PHONE = ENV['TWILIO_TEST_PHONE']

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
