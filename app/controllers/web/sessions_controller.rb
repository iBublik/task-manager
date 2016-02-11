module Web
  class SessionsController < ApplicationController
    before_action :redirect_if_signed_in, only: [:new, :create]
    before_action :redirect_if_not_signed_in, only: :destroy

    def new
    end

    def create
      if authentication_successfull?
        session[:user_id] = user.id
        redirect_to tasks_path, notice: t('.success')
      else
        flash.now.alert = t('.fail')
        render :new
      end
    end

    def destroy
      session.delete(:user_id)
      redirect_to root_path, notice: t('.success')
    end

    private

    def redirect_if_signed_in
      return unless user_signed_in?
      redirect_to root_path, alert: t('web.sessions.already_signed_in')
    end

    def redirect_if_not_signed_in
      return if user_signed_in?
      redirect_to root_path, alert: t('web.sessions.not_signed_in')
    end

    def authentication_successfull?
      user.try(:authenticate, session_params[:password])
    end

    def user
      @user ||= User.find_by(email: session_params[:email])
    end

    def session_params
      params.require(:session)
    end
  end
end
