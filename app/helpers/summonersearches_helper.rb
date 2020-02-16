module SummonersearchesHelper
  def icon(icon)
    @icon = "http://ddragon.leagueoflegends.com/cdn/#{@dd_version}/img/profileicon/#{icon}.png"
  end

  def champ_icon(champ_id)
    uri = URI.parse("https://ddragon.leagueoflegends.com/cdn/#{@dd_version}/data/ja_JP/champion.json")
    return_data = Net::HTTP.get(uri)
    @all_champ_data = JSON.parse(return_data)
    @select_champ = @all_champ_data['data'].values.find { |n| n["key"] == "#{champ_id}" }["id"] rescue nil
    @champ_icon = "http://ddragon.leagueoflegends.com/cdn/#{@dd_version}/img/champion/#{@select_champ}.png"
  end

  def spell(spell_id)
    uri = URI.parse("http://ddragon.leagueoflegends.com/cdn/#{@dd_version}/data/ja_JP/summoner.json")
    return_data = Net::HTTP.get(uri)
    @all_spell_data = JSON.parse(return_data)
    @spell = @all_spell_data['data'].values.find { |n| n["key"] == "#{spell_id}" }["id"] rescue nil
    @spell_icon = "http://ddragon.leagueoflegends.com/cdn/#{@dd_version}/img/spell/#{@spell}.png"
  end

  def rune(rune_id, primary, sub)
    uri = URI.parse("https://ddragon.leagueoflegends.com/cdn/#{@dd_version}/data/ja_JP/runesReforged.json")
    return_data = Net::HTTP.get(uri)
    @all_rune_data = JSON.parse(return_data)
    set_primary = [8100, 8300, 8000, 8400, 8200]
    primary_style = set_primary.find_index(primary)
    set_sub = set_primary.find_index(sub)
    @sub_style_icon = "https://ddragon.leagueoflegends.com/cdn/img/#{@all_rune_data[set_sub]['icon']}"
    primary_rune = @all_rune_data[primary_style]['slots'][0]['runes'].select{ |n| n['id'] == rune_id }[0]['icon']
    @primary_icon = "https://ddragon.leagueoflegends.com/cdn/img/#{primary_rune}"

  end

  def champ_splash(champ_id)
    champ_icon(champ_id)
    @splash = "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/#{@select_champ}_0.jpg"
  end


  def game_type(q_id)
    uri = URI.parse("http://static.developer.riotgames.com/docs/lol/queues.json")
    return_data = Net::HTTP.get(uri)
    @queues = JSON.parse(return_data)
    @game_mode = @queues.select{ |a| a["queueId"] == q_id }[0]['description']
  end
end
