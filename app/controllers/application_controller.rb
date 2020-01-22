class ApplicationController < ActionController::Base
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
    @@dd_version = dd_data[0]
  end

  def summoner_data(summoner_name)
    #ユーザを検索しIDを取得
    encode_uri = URI.encode("https://jp1.api.riotgames.com/lol/summoner/v4/summoners/by-name/#{summoner_name}?api_key=#{@@api}")
    uri = URI.parse(encode_uri)
    return_data = Net::HTTP.get(uri)
    @summoner_main_data = JSON.parse(return_data)
    @summoner_id = @summoner_main_data['id']

    #取得したIDから、ランクを表示
    uri = URI.parse("https://jp1.api.riotgames.com/lol/league/v4/entries/by-summoner/#{@summoner_id}?api_key=#{@@api}")
    return_data = Net::HTTP.get(uri)
    @summoner_data = JSON.parse(return_data)
  end

  protected

  # 入力フォームからアカウント名情報をDBに保存するために追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :summoner_id, :group_id, :admin, :favorite_summoner])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :summoner_id, :group_id, :admin, :favorite_summoner])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :email])
  end
end