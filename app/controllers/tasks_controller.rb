class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: :create
  before_action :set_task, only: %i[ update destroy toggle_completion ]

  def index
    @lists = current_user.lists.all
    @unlisted_tasks = current_user.tasks.where(list_id: [nil, ""])
  end

  def create
    if @list
        @task = @list.tasks.new(task_params)
        @task.user_id = current_user.id
    else
        @task = current_user.tasks.new(task_params)
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_back fallback_location: tasks_path }
        format.json { render :nothing => true, status: :created, location: @task }
      else
        flash[:error] = @task.errors.full_messages.join(', ')
        format.html { redirect_to request.referrer }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_back fallback_location: tasks_path }
        format.json { render :nothing => true, status: :ok, location: @task }
      else
        flash[:error] = @task.errors.full_messages.join(', ')
        format.html { redirect_to request.referrer }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: tasks_path }
      format.json { head :no_content }
    end
  end

  def toggle_completion
    @task.update_attribute(:completed, !@task.completed)
    redirect_back fallback_location: tasks_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_list
      if params.has_key?(:list_id)
        @list = List.find(params[:list_id])
      else
        @list = nil
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :completed, :description, :due_date, :due_time, :list_id)
    end
end
