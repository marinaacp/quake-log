class Kill < ApplicationRecord
  belongs_to :killer, class_name: 'Player', optional: true
  belongs_to :victim, class_name: 'Player'

  enum type_death: {
    mod_unknown: 0,
    mod_shotgun: 1,
    mod_gauntlet: 2,
    mod_machinegun: 3,
    mod_grenade: 4,
    mod_grenade_splash: 5,
    mod_rocket: 6,
    mod_rocket_splash: 7,
    mod_plasma: 8,
    mod_plasma_splash: 9,
    mod_railgun: 10,
    mod_lightning: 11,
    mod_bfg: 12,
    mod_bfg_splash: 13,
    mod_water: 14,
    mod_slime: 15,
    mod_lava: 16,
    mod_crush: 17,
    mod_telefrag: 18,
    mod_falling: 19,
    mod_suicide: 20,
    mod_target_laser: 21,
    mod_trigger_hurt: 22,
    mod_grapple: 23
  } # This enum does not include MISSIONPACK games

  validates :victim_id, :type_death, presence: true
end
