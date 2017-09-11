local chars = {
  principal = "link"
}

local sidekick
local current_map
local hero

local function other_char()
  if chars.principal == "link" then
    return "zelda"
  else
    return "link"
  end
end

local function get_sprite_for(name)
  if name == "zelda" then
    return "hero/tunic4"
  else
    return "hero/tunic1"
  end
end

function chars:create_sidekick(map)
  hero = map:get_game():get_hero()
  local x, y, layer = hero:get_position()
  current_map = map

  sidekick = map:create_custom_entity({
    direction=0,
    layer=layer,
    x=x,
    y=y,
    width=16,
    height=16,
    name="sidekick",
    sprite=get_sprite_for(other_char()),
    model="zelda"
  })
end

function chars:swap()
  if sidekick == nil then
    return
  end

  if chars.principal == "link" then
    hero:set_sword_sprite_id("hero/sword5")
  else
    hero:set_sword_sprite_id("hero/sword1")
  end

--  sidekick:create_sprite(get_sprite_for(chars.principal))

  chars.principal = other_char()
  hero:set_tunic_sprite_id(get_sprite_for(chars.principal))

  sidekick:remove()
  chars:create_sidekick(current_map)
end

return chars