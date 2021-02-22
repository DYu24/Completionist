class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: %i[ show edit update destroy ]

  def index
    @lists = current_user.lists.all
  end

  def show
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.create(list_params)

    respond_to do |format|
        if @list.save
          format.html { redirect_back fallback_location: @list }
          format.json { render :index, status: :created, location: @list }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @list.errors, status: :unprocessable_entity }
        end
      end
  end

  def edit
  end

  def update
    respond_to do |format|
        if @list.update(list_params)
          format.html { redirect_to @list, notice: "List was successfully updated." }
          format.json { render :show, status: :ok, location: @list }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @list.errors, status: :unprocessable_entity }
        end
      end
  end

  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_path }
      format.json { head :no_content }
    end
  end

  private
    def set_list
        @list = List.find(params[:id])
    end

    def list_params
        params.require(:list).permit(:name, :description)
    end
end
