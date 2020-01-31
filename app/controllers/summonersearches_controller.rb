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
    match_game if @summoner_name.present?

    @red_matches = []
    @blue_matches = []
    if @match_result.present? 
      @match_result.each do |m| 
        @red = m['participantIdentities'][0..4] 
        @blue = m['participantIdentities'][5..9] 
        @red_stats = m['participants'][0..4] 
        @blue_stats = m['participants'][5..9] 

        # game_type(m['queueId']) 

        @red_names = @red.map do |r|         
          r['player']['summonerName'] 
        end 
        @team_red = @red_stats.map.with_index do |r_stats, i|
          {"#{@red_names[i]}" => [r_stats['championId'], r_stats['stats']['kills'], r_stats['stats']['deaths']]}
        end
        @red_matches << @team_red 
    
        @blue_names = @blue.map do |b|         
          b['player']['summonerName']  
        end 
        @team_blue = @blue_stats.map.with_index do |b_stats, i|
          {"#{@blue_names[i]}" => [b_stats['championId'], b_stats['stats']['kills'], b_stats['stats']['deaths']]}
        end 
        @blue_matches << @team_blue
      end
      
    end 
  end
end
