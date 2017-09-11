local game_manager = {}


local initial_game = require("scripts/initial_game")
local chars = require("scripts/lib/chars")

-- Starts the game from the given savegame file,
-- initializing it if necessary.
function game_manager:start_game(file_name)
  local exists = sol.game.exists(file_name)
  game = sol.game.load(file_name)

  if not exists then
    -- Initialize a new savegame.
    initial_game:initialize_new_savegame(game)
  end

  game:start()

  local hero = game:get_hero()
  hero_steps = {}
  function hero:on_position_changed(x, y, layer)
    hero_steps[#hero_steps+1] = {x, y, hero:get_direction()}
    if #hero_steps > 25 then
      table.remove(hero_steps, 1)
    end
  end

  function game:on_map_changed(map)
    if game.sidekick then
      chars:create_sidekick(map, true)
    end
  end

  return game
end

return game_manager

