# frozen_string_literal: true

module Internationalizable
  extend ActiveSupport::Concern

  included do
    enum preferred_language: I18n.available_locales # [:en, :es]

    def send_devise_notification(notification, *args)
      I18n.with_locale(preferred_language || I18n.locale) do
        devise_mailer.send(notification, self, *args).deliver_later
      end
    end
  end
end
