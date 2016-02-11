require 'application_responder'

module Web
  class ApplicationController < ::ApplicationController
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    self.responder = ApplicationResponder
    respond_to :html

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    def user_signed_in?
      current_user.present?
    end
    helper_method :user_signed_in?

    def authenticate_user
      return if user_signed_in?
      redirect_to sign_in_path, alert: t('web.sessions.not_authenticated')
    end
  end
end
