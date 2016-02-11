module Web
  module Account
    class TasksController < ApplicationController
      before_action :authorize_entity, only: [:index, :new, :create]
      before_action :set_task, :authorize_task,
                    only: [:show, :edit, :update, :destroy, :switch_state]

      respond_to :json, only: :switch_state

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

      def switch_state
        @task.switch_state
        render json: task_links
      end

      private

      def task_links
        text_scope = "tasks.states.#{@task.current_state.name}"
        {
          current_state: t("#{text_scope}.name"),
          switch_text: (t("#{text_scope}.switch") if policy(@task).switch_state?)
        }.compact
      end

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
