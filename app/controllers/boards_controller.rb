class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def new
    @board = current_user.boards.build
  end
end
