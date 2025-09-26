# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter

class Admins::SessionsController < Devise::SessionsController
  include Accessible
  include AuthenticateWithOtpTwoFactor

  before_action :check_if_resource_already_signed_in, except: :destroy
  before_action :authenticate_with_otp_two_factor, if: -> { action_name == 'create' && otp_two_factor_enabled? }
end

# rubocop:enable Rails/LexicallyScopedActionFilter
