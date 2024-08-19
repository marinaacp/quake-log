class Player < ApplicationRecord
  belongs_to :game
  has_many :kills_as_killer, class_name: 'Kill', foreign_key: 'killer_id', dependent: :destroy
  has_many :kills_as_victim, class_name: 'Kill', foreign_key: 'victim_id', dependent: :destroy

  validates :name, :model, :id_in_log, presence: true

  def kills_data
    return {
      kills_as_killer: self.kills_as_killer,
      kills_as_victim: self.kills_as_victim
    }
  end
end
