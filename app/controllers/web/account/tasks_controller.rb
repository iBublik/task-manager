module Web
  module Account
    class TasksController < ApplicationController
      before_action :authorize_entity, only: [:index, :new, :create]
      before_action :set_task, :authorize_task, only: [:show, :edit, :update, :destroy]

      def index
        @tasks = policy_scope(Task)
        @tasks = @tasks.order(:created_at).page(params[:page])
      end

      def show
      end

      def new
        @task = Task.new
      end

      def create
        respond_with(@task = policy_scope(Task).create(task_params))
      end

      def edit
      end

      def update
        @task.update(task_params)
        respond_with @task
      end

      def destroy
        respond_with(@task.destroy)
      end

      private

      def task_params
        params.require(:task).permit(policy(Task).permitted_attributes)
      end

      def set_task
        @task = Task.find(params[:id])
      end

      def authorize_task
        authorize @task
      end

      def authorize_entity
        authorize Task
      end
    end
  end
end
