class Game < ApplicationRecord
  has_many :players, dependent: :destroy

  # This association receives all kills from a game that did not happen through "world"
  has_many :player_kills, through: :players, source: :kills_as_killer

  # This association receives all kills from a game. All kills have a victim_id"
  has_many :kills, through: :players, source: :kills_as_victim

  enum gametype: {
    gt_ffa: 0,
    gt_tournament: 1,
    gt_single_player: 2,
    gt_team: 3,
    gt_ctf: 4,
    gt_1fctf: 5,
    gt_obelisk: 6,
    gt_harvester: 7
  }

  validates :gametype, :fraglimit, :timelimit, :capturelimit, presence: true


  def game_data
    # Fetch all players in the game
    player_ids = self.players.pluck(:id)
    player_names = self.players.pluck(:id, :name).to_h

    # Calculate total kills and kills by each player
    total_kills = self.kills.count
    kills_summary = player_ids.each_with_object({}) do |player_id, hash|
      hash[player_names[player_id]] = player_kills.where(killer: player_id).count
    end

    return {
      total_kills: total_kills,
      players: player_names.values,
      kills: kills_summary
    }
  end
  

end
