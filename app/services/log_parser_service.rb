class LogParserService
  attr_reader :file

  def initialize(file)
    @file = file
  end

  def parse
    log_text = File.read(@file)

    # Check if the file contains any 'ClientConnect' event
    return unless log_text.include?('ClientConnect')

    # Open and read the file line by line
    File.foreach(@file) do |line|
      game = Game.last
      if line.include?('InitGame:')
        create_game(line)
      elsif line.include?('ClientUserinfoChanged:')
        check_if_player_existis(game, line)
      elsif line.include?('Kill:')
        create_kill(game, line)
      elsif line.include?('score:')
        update_player_score(game, line)
      end
    end
  end

  # private

  def create_game(line)
    game_values = find_value_game(line)

    # Create the game with extracted values
    Game.create!(
      gametype: game_values[:gametype],
      fraglimit: game_values[:fraglimit],
      timelimit: game_values[:timelimit],
      capturelimit: game_values[:capturelimit]
    )
  rescue Exception => e
    Rails.logger.error(YAML::dump(e))
  end


  def check_if_player_existis(game, line)
    player_values = find_value_player(line)

    id_in_log = player_values[:id_in_log]
    existing_player = Player.find_by(game_id: game.id, id_in_log: id_in_log)

    if existing_player.nil?
      create_player(player_values, game)
    else
      update_player(player_values, existing_player)
    end
  rescue Exception => e
    Rails.logger.error(YAML::dump(e))
  end


  def create_player(player_values, game)
    Player.create!(
      game_id: game.id,
      name: player_values[:name],
      model: player_values[:model],
      submodel: player_values[:submodel],
      id_in_log: player_values[:id_in_log]
    )
  rescue Exception => e
    Rails.logger.error(YAML::dump(e))
  end


  def update_player(player_values, existing_player)
    existing_player.update!(
      name: player_values[:name],
      model: player_values[:model],
      submodel: player_values[:submodel],
      id_in_log: player_values[:id_in_log]
    )
  rescue Exception => e
    Rails.logger.error(YAML::dump(e))
  end


  def update_player_score(game, line)
    score_values = find_value_score(line)
    player = Player.find_by(game_id: game.id, id_in_log: score_values[:id_in_log])
    player.update!(
      score: score_values[:score]
    )
  rescue Exception => e
    Rails.logger.error(YAML::dump(e))
  end


  def create_kill(game, line)
    kill_values = find_value_kill(line)

    killer = nil
    if kill_values[:log_killer_id] != 1022
      killer = Player.find_by(game_id: game.id, id_in_log: kill_values[:log_killer_id])
    end
    victim = Player.find_by(game_id: game.id, id_in_log: kill_values[:log_victim_id])

    # Create the game with extracted values
    Kill.create!(
      killer: killer,
      victim: victim,
      type_death: kill_values[:type_death],
      is_world_death: killer.nil? ? true : false
    )
  rescue Exception => e
    Rails.logger.error(YAML::dump(e))
  end


  def find_value_game(line)
    # Match the log structure using a regular expression
    match_data = line.scan(/(\w+)\\(\d+)/).to_h

    # Extract values
    hash = {
      gametype: match_data['g_gametype'].to_i,
      fraglimit: match_data['fraglimit'].to_i,
      timelimit: match_data['timelimit'].to_i,
      capturelimit: match_data['capturelimit'].to_i
    }
    return hash
  rescue Exception => e
    Rails.logger.error(YAML::dump(e))
  end


  def find_value_player(line)
    # Match the log structure using a regular expression
    match_data = line.match(/ClientUserinfoChanged: (\d+) n\\([^\\]+)\\.*model\\([^\\\/]+)(?:\/([^\\]+))?/)

    # Extract the values
    hash = {
      id_in_log: match_data[1].to_i,
      name: match_data[2],
      model: match_data[3],
      submodel: match_data[4] || nil
    }
    return hash
  rescue Exception => e
    Rails.logger.error(YAML::dump(e))
  end


  def find_value_score(line)
    # Match the log structure using a regular expression
    match_data = line.match(/score:\s(\d+).*client:\s(\d+)/)

    # Extract the values for score and client
    hash = {
      score: match_data[1].to_i,
      id_in_log: match_data[2].to_i
    }
    return hash
  rescue Exception => e
    Rails.logger.error(YAML::dump(e))
  end


  def find_value_kill(line)
    # Match the log structure using a regular expression
    match_data = line.match(/Kill:\s(\d+)\s(\d+)\s(\d+)/)

    # Extract the values for the three numbers
    hash = {
      log_killer_id: match_data[1].to_i,
      log_victim_id: match_data[2].to_i,
      type_death: match_data[3].to_i
    }

    return hash
  rescue Exception => e
    Rails.logger.error(YAML::dump(e))
  end

end
