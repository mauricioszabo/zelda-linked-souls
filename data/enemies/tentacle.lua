local enemy = ...

-- Tentacle: a basic enemy that follows the hero.

local behavior = require("enemies/lib/towards_hero")

local properties = {
  sprite = "enemies/" .. enemy:get_breed(),
  life = 10,
  damage = 1,
  normal_speed = 24,
  faster_speed = 24,
}

behavior:create(enemy, properties)

