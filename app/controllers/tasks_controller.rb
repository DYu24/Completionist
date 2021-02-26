class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, except: [:index]
  before_action :set_task, only: %i[ show edit update destroy toggle_completion ]

  def index
    @lists = current_user.lists.all
  end

  def show
  end

  def create
    @task = @list.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_back fallback_location: @list }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_back fallback_location: @list }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: @list }
      format.json { head :no_content }
    end
  end

  def toggle_completion
    @task.update_attribute(:completed, !@task.completed)
    redirect_back fallback_location: @list
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :completed, :description, :due_date, :due_time)
    end
end
