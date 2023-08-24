# frozen_string_literal: true

class Recruiters::RegistrationsController < Devise::RegistrationsController
  include Accessible

  before_action :check_if_resource_signed_in, only: %i[new create]
end
