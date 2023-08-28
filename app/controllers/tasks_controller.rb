class TasksController < ApplicationController
  before_action :set_board, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :set_task, only: [:show, :edit, :update]

  def show
  end

  def new
    @task = @board.tasks.build
  end

  def create
    @task = @board.tasks.build(task_params)
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
    if @task.update(task_params)
      redirect_to board_task_path(@task), notice: 'Updated'
    else
      flash.now[:error] = 'Not updated'
      render :edit
    end
  end

  def destroy

  end

  private
  def task_params
    params.require(:task).permit(:name, :description, :eyecatch)
  end

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_task
    @task = @board.tasks.find(params[:id])
  end
end