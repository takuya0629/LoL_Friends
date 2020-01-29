class SummonersearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @summoner_name = params[:search]
    #アカウントが正常化かチェック
    check_account(@summoner_name) unless @summoner_name == nil
    if @check_data.present? && @check_data['name'] == nil
      return flash.now[:notice] = "サモナーのアカウントが存在しません"
    end
    #正常だった場合
    summoner_data(@summoner_name)
    profile_icon(@summoner_main_data)
  end
end
