-- This is the main Lua script of your project.
-- You will probably make a title screen and then start a game.
-- See the Lua API! http://www.solarus-games.org/doc/latest

require("scripts/features")
doors = require("scripts/lib/doors")

local game_manager = require("scripts/game_manager")
local game = nil

-- This function is called when Solarus starts.
function sol.main:on_started()

  doors:initialize()

  -- Setting a language is useful to display text and dialogs.
  -- sol.language.set_language("en")

  local solarus_logo = require("scripts/menus/solarus_logo")

  -- Show the Solarus logo initially.
  sol.menu.start(self, solarus_logo)
  sol.language.set_language("en")

  -- Start the game when the Solarus logo menu is finished.
  solarus_logo.on_finished = function()
    game = game_manager:start_game("save1.dat")
  end

end

-- Event called when the player pressed a keyboard key.
function sol.main:on_key_pressed(key, modifiers)
  local hero = game:get_hero()
  local handled = false

  if key == "f5" then
    -- F5: change the video mode.
    sol.video.switch_mode()
    handled = true
  elseif key == "f11" or
    (key == "return" and (modifiers.alt or modifiers.control)) then
    -- F11 or Ctrl + return or Alt + Return: switch fullscreen.
    sol.video.set_fullscreen(not sol.video.is_fullscreen())
    handled = true
  elseif key == "f4" and modifiers.alt then
    -- Alt + F4: stop the program.
    sol.main.exit()
    handled = true
  elseif key == "escape" and sol.main.game == nil then
    -- Escape in title screens: stop the program.
    sol.main.exit()
    handled = true
  elseif key == "q" then
    hero:set_sword_sprite_id("hero/sword1")
    hero:set_tunic_sprite_id("hero/tunic1")
  elseif key == "w" then
    hero:set_sword_sprite_id("hero/sword5")
    hero:set_tunic_sprite_id("hero/tunic4")
    end

  return handled
end
