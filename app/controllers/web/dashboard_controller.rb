module Web
  class DashboardController < ApplicationController
    def index
      @tasks = Task.order(:created_at).includes(:user).page(params[:page])
    end
  end
end
