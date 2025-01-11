class ApplicationController < ActionController::Base
  before_action :set_local_disk_storage
  around_action :switch_locale

  def switch_locale(&action)
    I18n.with_locale(locale_from_header, &action)
  end

  private

    def locale_from_header
      request.env["HTTP_ACCEPT_LANGUAGE"]&.scan(/^[a-z]{2}/)&.first
    end

    def set_local_disk_storage
      return unless Rails.env.development?

      ActiveStorage::Current.url_options = { host: "localhost", port: 3000 }
    end
end
