# frozen_string_literal: true

class Candidates::RegistrationsController < Devise::RegistrationsController
  include Accessible

  before_action :check_if_resource_already_signed_in, only: %i[new create]
end
