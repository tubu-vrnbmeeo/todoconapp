class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def new
    
  end
end
