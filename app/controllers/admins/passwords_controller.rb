# frozen_string_literal: true

class Admins::PasswordsController < Devise::PasswordsController
  include Accessible

  before_action :check_if_resource_already_signed_in
end
