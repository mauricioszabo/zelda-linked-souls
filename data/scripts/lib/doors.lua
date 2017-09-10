local doors = {}

local function initialize_home_doors()
  local sensor_meta = sol.main.get_metatable("sensor")

  function sensor_meta:on_activated()
    local hero = self:get_map():get_hero()
    local game = self:get_game()
    local map = self:get_map()
    local name = self:get_name()

    -- Sensors called open_house_xxx_sensor automatically open an outside house door tile.
    local door_name = name:match("^open_house_([a-zA-X0-9_]+)")
    if door_name ~= nil then
      local door = map:get_entity(door_name)
      if door ~= nil then
        if hero:get_direction() == 1
	         and door:is_enabled() then
          door:set_enabled(false)
          sol.audio.play_sound("door_open")
        end
      end
    end
  end
end

-- Performs global initializations specific to this quest.
function doors:initialize()
  initialize_home_doors()
end

return doors