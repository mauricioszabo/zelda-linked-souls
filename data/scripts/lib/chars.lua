local chars = {
  principal = "link",
  link_sword = 0,
  zelda_sword = 1,
  link_strength = 1
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

function chars:create_sidekick(map, update)
  hero = map:get_game():get_hero()
  local x, y, layer = hero:get_position()
  current_map = map

  if update then
    hero_steps = {{x, y, hero:get_direction()}}
  end

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

  local game = current_map:get_game()

  if chars.principal == "link" then
    hero:set_sword_sprite_id("hero/sword5")
    game:set_ability("sword", chars.zelda_sword)
    game:set_ability("lift", 0)
  else
    hero:set_sword_sprite_id("hero/sword1")
    game:set_ability("sword", chars.link_sword)
    game:set_ability("lift", chars.link_strength)
  end

--  sidekick:create_sprite(get_sprite_for(chars.principal))

  chars.principal = other_char()
  hero:set_tunic_sprite_id(get_sprite_for(chars.principal))

  sidekick:remove()
  chars:create_sidekick(current_map, false)
end

return chars