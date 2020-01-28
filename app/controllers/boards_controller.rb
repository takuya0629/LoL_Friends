class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: %i[show edit update destroy]

  def index
    @boards = Board.all
  end

  def show
    gon.current_user = current_user
    gon.board = @board
    @responses = @board.responses.order(:created_at)
    # a = Board.last.responses.build(user_id: 1, content: 'aaa')
    
    if @responses.length > 100
      @over_ten = true
      @responses = response.where(id: @responses[-10..-1].pluck(:id))
    end

    if params[:m]
      @over_ten = false
      @responses = @conversation.responses
    end

    @responses = @responses.order(:created_at)
    @response = @board.responses.build
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if params[:back]
      render :new 
    elsif @board.save
      redirect_to @board, notice: '掲示板を作成しました' 
    else
      render :new
    end
  end

  def destroy
    
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :content)
  end

end
