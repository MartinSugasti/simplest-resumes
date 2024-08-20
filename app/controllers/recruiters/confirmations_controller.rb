# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter

class Recruiters::ConfirmationsController < Devise::ConfirmationsController
  include Accessible

  before_action :check_if_resource_already_signed_in
  before_action :check_if_confirmation_available, only: :show
end

# rubocop:enable Rails/LexicallyScopedActionFilter
