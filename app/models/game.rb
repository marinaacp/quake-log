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

  validates :gametype, :fraglimit, :timelimit, presence: true
end
