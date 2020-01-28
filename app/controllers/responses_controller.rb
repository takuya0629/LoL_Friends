class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def show

  end

  def create
  end

  private

  def response_params
    params.require(:responses).permit(:content)
  end

  def set_board
    @board = Board.find(params[:id])
  end
end
