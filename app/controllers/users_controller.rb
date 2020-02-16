class UsersController < ApplicationController
  before_action :authenticate_user!

  def user_search
    @search_user = User.ransack(params[:q])
    if params[:q] && params[:q][:name_cont].present?
      @user = @search_user.result(distinct: true)
    end
    flash.now[:warning] = '入力されたユーザーは存在しません。' if @user.blank? && params[:q]
  end

  def my_group
    @my_groups = current_user.my_groups.page(params[:page]).per(4)
  end

end
