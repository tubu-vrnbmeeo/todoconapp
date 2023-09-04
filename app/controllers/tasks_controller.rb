class TasksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_task, only: [:edit, :update]
  def show
    @task = Task.find(params[:id])
    @comments = @task.comments
  end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(**task_params, user_id: current_user.id)
    if @task.save
      redirect_to board_path(board), notice: 'Task added'
    else
      flash.now[:error] = 'Task could not be added'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(**task_params, user_id: current_user.id)
      redirect_to board_task_path(board_id: @task.board.id, id: @task.id), notice: 'Updated'
    else
      flash.now[:error] = 'Not updated'
      render :edit
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to board_path(board), notice: 'Deleted'
  end

  private
  def task_params
    params.require(:task).permit(:name, :description, :eyecatch)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end