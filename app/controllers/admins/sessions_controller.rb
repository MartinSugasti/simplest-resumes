# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  include Accessible

  before_action :check_if_resource_signed_in, except: :destroy
end
