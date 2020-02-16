class ResponsesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board

  def show

  end

  def create
  end

  def destroy
    @response = Response.find(params[:id])
    @response.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to board_path(@board)
  end

  private

  def response_params
    params.require(:responses).permit(:content)
  end

  def set_board
    @board = Board.find(params[:id])
  end
end
