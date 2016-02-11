module Web
  module Account
    class ApplicationController < ::Web::ApplicationController
      before_action :authenticate_user

      after_action :verify_authorized
      after_action :verify_policy_scoped, only: :index

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      private

      def user_not_authorized
        error = t('web.sessions.not_authorized')
        respond_to do |format|
          format.html { redirect_to root_path, alert: error }
          format.json { render json: { error: error }, status: :forbidden }
        end
      end
    end
  end
end
