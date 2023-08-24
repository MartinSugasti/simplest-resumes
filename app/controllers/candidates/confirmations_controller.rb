# frozen_string_literal: true

class Candidates::ConfirmationsController < Devise::ConfirmationsController
  include Accessible

  before_action :check_if_resource_signed_in
  before_action :check_if_confirmation_available, only: :show
end
