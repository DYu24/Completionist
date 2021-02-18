class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, except: :get_all
  before_action :set_task, only: %i[ show edit update destroy toggle_completion ]

  def get_all
    @tasks = []
    all_lists = current_user.lists.all
    all_lists.each do |list|
        @tasks.concat(list.tasks.all)
    end

    render :index
  end

  def index
    @tasks = @list.tasks.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = @list.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to list_task_path(@list, @task), notice: "Task was successfully created." }
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
        format.html { redirect_to list_task_path(@list, @task), notice: "Task was successfully updated." }
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
      format.html { redirect_to @list, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def toggle_completion
    @task.update_attribute(:completed, !@task.completed)
    redirect_to @list
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
      params.require(:task).permit(:title, :completed)
    end
end
