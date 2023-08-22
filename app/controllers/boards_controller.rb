class BoardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @boards = Board.all
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to board_path, notice: '保存しました'
    else
      flash.now[:error] = '保存できませんでした'
      render :new
    end
  end

  private
  def board_params
    params.require(:board).permit(:name, :description)
  end
end
