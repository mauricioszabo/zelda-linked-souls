-- Lua script of map first_map.
-- This script is executed every time the hero enters this map.

-- Feel free to modify the code below.
-- You can add more events and remove the ones you don't need.

-- See the Solarus Lua API documentation:
-- http://www.solarus-games.org/doc/latest

local map = ...
local game = map:get_game()
local chars = require("scripts/lib/chars")

local night_overlay = sol.surface.create(map:get_size())
local alpha = 220
night_overlay:fill_color({0, 0, 64, alpha})


-- Event called at initialization time, as soon as this map becomes is loaded.
function map:on_started()

  -- You can initialize the movement and sprites of various
  -- map entities here.
  --map:get_game():start_dialog("1_start")
  if game.intro then
    bed:get_sprite():set_animation("hero_sleeping")
    hero:freeze()
    hero:set_visible(false)
    
    game:start_dialog("part1.zelda_explaining", function()
      sol.timer.start(map, 1000, function()
        bed:get_sprite():set_animation("hero_waking")
        sol.timer.start(map, 500, function()
          hero:set_visible(true)
          hero:start_jumping(0, 24, true)
          game:set_pause_allowed(true)
          game:set_hud_enabled(true)
          bed:get_sprite():set_animation("empty_open")
          sol.audio.play_sound("hero_lands")

          sol.timer.start(map, 500, function()
            zelda:set_visible(false)
            chars:create_sidekick(map)
            return false
          end)

          sol.timer.start(map, 20, function()
            alpha = alpha - 1
            if alpha <= 0 then
              alpha = 0
            end
            night_overlay:clear()
            night_overlay:fill_color({0, 0, 64, alpha})

            -- Continue the timer if there is still night.
            return alpha > 0
          end)
        end)
      end)
    end)

    --map:fade_in(4000)
    --game:start_dialog("part1.start")
  else
    night_overlay:clear()
    zelda:set_visible(false)
  end
end

-- Event called after the opening transition effect of the map,
-- that is, when the player takes control of the hero.
function map:on_opening_transition_finished()

end

function map:on_draw(dst_surface)
  night_overlay:draw(dst_surface)
end

