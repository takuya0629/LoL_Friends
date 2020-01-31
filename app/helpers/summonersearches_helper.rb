module SummonersearchesHelper
  def icon(icon)
    @icon = "http://ddragon.leagueoflegends.com/cdn/#{@dd_version}/img/profileicon/#{icon}.png"
  end

  def champ_icon(champ_id)
    uri = URI.parse("https://ddragon.leagueoflegends.com/cdn/#{@dd_version}/data/ja_JP/champion.json")
    return_data = Net::HTTP.get(uri)
    @all_champ_data = JSON.parse(return_data)
    select_champ = @all_champ_data['data'].values.find { |n| n["key"] == "#{champ_id}" }["id"] rescue nil
    @champ_icon = "http://ddragon.leagueoflegends.com/cdn/#{@dd_version}/img/champion/#{select_champ}.png"
  end

  def game_type(q_id)
    uri = URI.parse("http://static.developer.riotgames.com/docs/lol/queues.json")
    return_data = Net::HTTP.get(uri)
    @queues = JSON.parse(return_data)
    @game_mode = @queues.select{ |a| a["queueId"] == q_id }[0]['description']
  end
end
