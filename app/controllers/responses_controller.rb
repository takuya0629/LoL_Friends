class ResponsesController < ApplicationController
  before_action :authenticate_user!
  

  def show

  end

  def create
  end

  def destroy
    @response = Response.find(params[:id])
    @board = @response.board
    @response.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to board_path(@board)
  end

  private

  def response_params
    params.require(:responses).permit(:content)
  end
end
