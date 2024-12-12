# frozen_string_literal: true

module Api
  module V1
    class TasksController < NamespaceController
      before_action :set_task, only: %i[show update destroy]

      rescue_from StandardError do |e|
        render json: { error: 'An unexpected error occurred', details: e.message }, status: :internal_server_error
      end

      def index
        tasks = Task.rank(:row_order).all
        ordered_tasks = tasks.map.with_index do |task, index|
          {
            id: task.id,
            title: task.title,
            description: task.description,
            row_order: index,
            created_at: task.created_at,
            updated_at: task.updated_at
          }
        end
        render json: ordered_tasks, status: :ok
      end

      def show
        render json: @task.formatted_json, status: :created
      end

      def create
        task = Task.new(task_params)
        if task.save
          render json: task.formatted_json, status: :created
        else
          render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          render json: @task.formatted_json, status: :ok
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        if @task.destroy
          render json: { message: 'Task deleted successfully' }, status: :ok
        else
          render json: { error: 'Task could not be deleted' }, status: :unprocessable_entity
        end
      end

      # requires a list of tasks ids
      # Example input:
      # { "tasks": [1,2,3,4,5.....]}
      def reorder
        task_ids = params[:tasks]

        existing_task_ids = Task.where(id: task_ids).pluck(:id)
        missing_task_ids = task_ids.map(&:to_i) - existing_task_ids

        if missing_task_ids.any?
          render json: { error: "Invalid task IDs: #{missing_task_ids.join(', ')}" }, status: :unprocessable_entity
          return
        end

        params[:tasks].each_with_index do |id, index|
          task = Task.find(id)
          task.update(row_order_position: index)
        end
        render json: { message: 'Task reordered successfully' }, status: :ok
      end

      private

      def set_task
        @task = Task.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Task not found' }, status: :not_found
      end

      def task_params
        params.require(:task).permit(:title, :description, :row_order_position)
      end
    end
  end
end
