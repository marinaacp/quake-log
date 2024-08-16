class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :kills, through: :players
end
