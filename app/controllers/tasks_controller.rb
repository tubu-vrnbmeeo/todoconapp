class TasksController < ApplicationController
  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
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
end