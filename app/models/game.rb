class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :kills, through: :players

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

  validates :gametype, :fraglimit, :timelimit, :duration, presence: true
end
