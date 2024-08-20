# frozen_string_literal: true

# rubocop:disable Rails/LexicallyScopedActionFilter

class Candidates::SessionsController < Devise::SessionsController
  include Accessible

  before_action :check_if_resource_already_signed_in, except: :destroy
end

# rubocop:enable Rails/LexicallyScopedActionFilter
