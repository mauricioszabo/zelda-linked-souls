local zelda = ...

local game = zelda:get_game()
local map = game:get_map()
local sprite = zelda:get_sprite()
local hero = game:get_hero()

sprite:set_animation("stopped")
zelda:set_optimization_distance(0)
zelda:set_drawn_in_y_order(true)

zelda:set_traversable_by(true)
zelda:set_traversable_by("hero", false)

zelda:set_can_traverse("enemy", true)
zelda:set_can_traverse("npc", true)
zelda:set_can_traverse("sensor", true)
zelda:set_can_traverse("separator", true)
zelda:set_can_traverse("stairs", true)
zelda:set_can_traverse("teletransporter", true)

zelda:set_can_traverse("hero", true)
zelda:set_traversable_by("hero", true)


local walking = false

sol.timer.start(zelda, 20, function()
  local last_step = hero_steps[1]
  local last_x, last_y = zelda:get_position()
--  io.write("\nX:", last_step[1], "\tY:", last_step[2], " last_x:", last_x, " last_y:", last_y)

  if last_x == last_step[1] and last_y == last_step[2] then
    if walking then
      sprite:set_animation("stopped")
      walking = false
    end
  else
    zelda:set_position(last_step[1], last_step[2])
    sprite:set_direction(last_step[3])
    last_x, last_y = zelda:get_position()

    if not walking then
      sprite:set_animation("walking")
      walking = true
    end
  end
  return true
end)
