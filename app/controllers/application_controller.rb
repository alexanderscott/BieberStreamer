class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def friendly_token
      SecureRandom.urlsafe_base64(15).tr('lIO0', 'sxyz')
    end

    helper_method :friendly_token

end
