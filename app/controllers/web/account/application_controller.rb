module Web
  module Account
    class ApplicationController < ::Web::ApplicationController
      before_action :authenticate_user

      after_action :verify_authorized
      after_action :verify_policy_scoped, only: :index

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      private

      def user_not_authorized
        redirect_to root_path, alert: t('web.sessions.not_authorized')
      end
    end
  end
end
