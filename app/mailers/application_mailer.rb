# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  layout 'mailer'
  prepend_view_path 'app/views/mailers'

  default from: email_address_with_name('no-reply@simplestresumes.com', I18n.t('mailers.from.no_reply'))
end
