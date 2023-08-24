# frozen_string_literal: true

class Recruiters::PasswordsController < Devise::PasswordsController
  include Accessible

  before_action :check_if_resource_signed_in
end
