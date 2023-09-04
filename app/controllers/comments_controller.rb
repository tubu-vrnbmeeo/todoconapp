class CommentsController < ApplicationController
  def new
    task = Board.find(params[:board_id]).tasks.find(params[:task_id])
    @comment = task.comments.build
  end

  def create
    task = Board.find(params[:board_id]).tasks.find(params[:task_id])
    @comment = task.comments.build(comment_params)
    if @comment.save
      redirect_to board_task_path(board_id: task.board.id, id: task.id), notice: 'Comment added'
    else
      flash.now[:error] = 'Comment could not be added'
      render :new
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end

end