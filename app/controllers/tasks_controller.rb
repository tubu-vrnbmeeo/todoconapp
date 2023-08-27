class TasksController < ApplicationController
  before_action :set_board, only: [:show, :new, :create]

  def show
    @task = @board.tasks.find(params[:id])
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

  private
  def task_params
    params.require(:task).permit(:name, :description, :eyecatch)
  end

  def set_board
    @board = Board.find(params[:board_id])
  end
end