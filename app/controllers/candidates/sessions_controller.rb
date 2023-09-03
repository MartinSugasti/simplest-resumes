# frozen_string_literal: true

class Candidates::SessionsController < Devise::SessionsController
  include Accessible

  before_action :check_if_resource_already_signed_in, except: :destroy
end
