class ApplicationController < ActionController::Base
  require 'net/http'

  before_action :configure_permitted_parameters, if: :devise_controller?
  env = Dotenv.load
  @@api = env['api']
  
  # このアクションを追加
  def after_sign_in_path_for(resource)
    "/user/#{current_user.id}"
  end
  
  def ddragon_version
    #datedragonのバージョン
    uri = URI.parse("https://ddragon.leagueoflegends.com/api/versions.json")
    return_data = Net::HTTP.get(uri)
    dd_data = JSON.parse(return_data)
    @dd_version = dd_data[0]
  end

  def profile_icon(summoner_main_data)
    ddragon_version
    @icon = "http://ddragon.leagueoflegends.com/cdn/#{@dd_version}/img/profileicon/#{summoner_main_data['profileIconId']}.png"
  end

  def match_data
    uri = URI.parse("https://jp1.api.riotgames.com/lol/match/v4/matchlists/by-account/#{@summoner_main_data['accountId']}?api_key=#{@@api}")
    return_data = Net::HTTP.get(uri)
    @match_data = JSON.parse(return_data)
    @latest_ten_match = []
    if  @match_data['matches'].present?
      @match_data['matches'].first(3).each do |hash|
        @latest_ten_match << hash['gameId']
      end
    end
  end

  def match_game
    match_data
    @match_result = []
    @match_summoner_name = []

    @latest_ten_match.each do |id|
      uri = URI.parse("https://jp1.api.riotgames.com/lol/match/v4/matches/#{id}?api_key=#{@@api}")
      return_data = Net::HTTP.get(uri)
      @game_data = JSON.parse(return_data)
      @match_result << @game_data
    end
  end

  def position_mapping

  end

  def summoner_data(summoner_name)
    #ユーザを検索し、IDを取得
    encode_uri = URI.encode("https://jp1.api.riotgames.com/lol/summoner/v4/summoners/by-name/#{summoner_name}?api_key=#{@@api}")
    uri = URI.parse(encode_uri)
    return_data = Net::HTTP.get(uri)
    @summoner_main_data = JSON.parse(return_data)
    @summoner_id = @summoner_main_data['id']

    #取得したIDから、ランクを表示
    uri = URI.parse("https://jp1.api.riotgames.com/lol/league/v4/entries/by-summoner/#{@summoner_id}?api_key=#{@@api}")
    return_data = Net::HTTP.get(uri)
    @rank_data = JSON.parse(return_data)
  end

  def check_account(summoner_name)
    #名前が正しいアカウントか判定
    encode_uri = URI.encode("https://jp1.api.riotgames.com/lol/summoner/v4/summoners/by-name/#{summoner_name}?api_key=#{@@api}")
    uri = URI.parse(encode_uri)
    return_data = Net::HTTP.get(uri)
    @check_data = JSON.parse(return_data)
  end

  protected

  # 入力フォームからアカウント名情報をDBに保存するために追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :summoner_id, :group_id, :admin, :favorite_summoner])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :summoner_id, :group_id, :admin, :favorite_summoner, :avater, :email, :introduction])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email])
  end
end