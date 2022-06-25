---localmenu opption
localmenu = menu.add_feature("MmtLuaScript","parent",0)
modmenu  = menu.add_feature("玩家娱乐功能/Mod","parent",localmenu.id)
---Swim
swim = menu.add_feature("Swim", "parent", modmenu.id, function(f)
end)
swimanywhere = menu.add_feature("陆地游泳/SwimAnyWhere", "toggle", swim.id, function(f,pid)
pedmy = player.get_player_ped(player.player_id())
while f.on do
ped.set_ped_config_flag(pedmy, 65, 1)
system.yield(0)
end
f.on = false
end)

---工艺模式 ---翅膀
wingstofly = menu.add_feature("Wing", "parent", modmenu.id, function(f)

end)
--graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(120,0,75),0.5)
--graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, p0,p1,p2)
--p0 where to set on entity
--p1 set rot
--p2 which size that u want to set
---火焰翅膀
ghostrider1= menu.add_feature("翅膀1","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(120,0,75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider1.threaded = true
ghostrider1.hidden = true 

ghostrider2= menu.add_feature("翅膀2","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(120,0,-75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider2.threaded = true
ghostrider2.hidden = true 


ghostrider3= menu.add_feature("翅膀5","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(135,0,75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider3.threaded = true
ghostrider3.hidden = true 

ghostrider4= menu.add_feature("翅膀6","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(135,0,-75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider4.threaded = true 
ghostrider4.hidden = true 

ghostrider5= menu.add_feature("翅膀6","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(135,0,-75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider5.threaded = true 
ghostrider5.hidden = true 

ghostrider6= menu.add_feature("翅膀7","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(140,0,75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider6.threaded = true 
ghostrider6.hidden = true 

ghostrider7= menu.add_feature("翅膀8","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(140,0,-75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider7.threaded = true 
ghostrider7.hidden = true 

ghostrider8= menu.add_feature("翅膀9","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(200,0,75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider8.threaded = true 
ghostrider8.hidden = true 

ghostrider9= menu.add_feature("翅膀10","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(200,0,-75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider9.threaded = true 
ghostrider9.hidden = true 

ghostrider10= menu.add_feature("翅膀11","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(190,0,75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider10.threaded = true 
ghostrider10.hidden = true 

ghostrider11= menu.add_feature("翅膀12","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(190,0,-75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider11.threaded = true 
ghostrider11.hidden = true 

ghostrider12= menu.add_feature("翅膀13","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(180,0,75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider12.threaded = true 
ghostrider12.hidden = true 

ghostrider13= menu.add_feature("翅膀14","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(180,0,-75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider13.threaded = true 
ghostrider13.hidden = true 

ghostrider14= menu.add_feature("翅膀15","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(175,0,75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider14.threaded = true 
ghostrider14.hidden = true 

ghostrider15= menu.add_feature("翅膀16","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(175,0,-75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider15.threaded = true 
ghostrider15.hidden = true 

ghostrider16= menu.add_feature("翅膀17","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(160,0,75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider16.threaded = true 
ghostrider16.hidden = true 

ghostrider17= menu.add_feature("翅膀18","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(160,0,-75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider17.threaded = true 
ghostrider17.hidden = true 

ghostrider18= menu.add_feature("翅膀19","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(150,0,75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider18.threaded = true 
ghostrider18.hidden = true 

ghostrider19= menu.add_feature("翅膀20","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(150,0,-75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider19.threaded = true 
ghostrider19.hidden = true 

ghostrider20= menu.add_feature("翅膀21","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(135,0,75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider20.threaded = true 
ghostrider20.hidden = true 

ghostrider21= menu.add_feature("翅膀22","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(135,0,-75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider21.threaded = true 
ghostrider21.hidden = true 

ghostrider22= menu.add_feature("翅膀23","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(130,0,75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider22.threaded = true 
ghostrider22.hidden = true 

ghostrider23= menu.add_feature("翅膀24","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(130,0,-75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider23.threaded = true 
ghostrider23.hidden = true 

ghostrider24= menu.add_feature("翅膀25","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(125,0,75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider24.threaded = true 
ghostrider24.hidden = true 

ghostrider25= menu.add_feature("翅膀26","toggle",wingstofly.id,function(k,pid)
while k.on do	   
pedmy = player.get_player_ped(player.player_id())
local titlle = "weap_xs_vehicle_weapons"
local hashid = "muz_xs_turret_flamethrower_looping"
graphics.set_next_ptfx_asset(titlle)
while not graphics.has_named_ptfx_asset_loaded(titlle) do
graphics.request_named_ptfx_asset(titlle)
system.wait(0)
end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedmy, v3(0,0,0.1), v3(125,0,-75),0.5)
system.wait(500)
end
k.on = false
graphics.remove_ptfx_from_entity(pedmy)
end)
ghostrider25.threaded = true 
ghostrider25.hidden = true 

ghostriderfly= menu.add_feature("Fire-Wing","toggle",wingstofly.id,function(k,pid)
while k.on do	   
ghostrider1.on = true
system.wait(0)
ghostrider2.on = true
system.wait(0)
ghostrider3.on = true
system.wait(0)
ghostrider4.on = true
system.wait(0)
ghostrider5.on = true
system.wait(0)
ghostrider6.on = true
system.wait(0)
ghostrider7.on = true
system.wait(0)
ghostrider8.on = true
system.wait(0)
ghostrider9.on = true
system.wait(0)
ghostrider10.on = true
system.wait(0)
ghostrider11.on = true
system.wait(0)
ghostrider12.on = true
system.wait(0)
ghostrider13.on = true
system.wait(0)
ghostrider14.on = true
system.wait(0)
ghostrider15.on = true
system.wait(0)
ghostrider16.on = true
system.wait(0)
ghostrider17.on = true
system.wait(0)
ghostrider18.on = true
system.wait(0)
ghostrider19.on = true
system.wait(0)
ghostrider20.on = true
system.wait(0)
ghostrider21.on = true
system.wait(0)
ghostrider22.on = true
system.wait(0)
ghostrider23.on = true
system.wait(0)
ghostrider24.on = true
system.wait(0)
ghostrider25.on = true
system.wait(0)
end
k.on = false
ghostrider1.on = false
system.wait(0)
ghostrider2.on = false
system.wait(0)
ghostrider3.on = false
system.wait(0)
ghostrider4.on = false
system.wait(0)
ghostrider5.on = false
system.wait(0)
ghostrider6.on = false
system.wait(0)
ghostrider7.on = false
system.wait(0)
ghostrider8.on = false
system.wait(0)
ghostrider9.on = false
system.wait(0)
ghostrider10.on = false
system.wait(0)
ghostrider11.on = false
system.wait(0)
ghostrider12.on = false
system.wait(0)
ghostrider13.on = false
system.wait(0)
ghostrider14.on = false
system.wait(0)
ghostrider15.on = false
system.wait(0)
ghostrider16.on = false
system.wait(0)
ghostrider17.on = false
system.wait(0)
ghostrider18.on = false
system.wait(0)
ghostrider19.on = false
system.wait(0)
ghostrider20.on = false
system.wait(0)
ghostrider21.on = false
system.wait(0)
ghostrider22.on = false
system.wait(0)
ghostrider23.on = false
system.wait(0)
ghostrider24.on = false
system.wait(0)
ghostrider25.on = false
system.wait(0)
end)
ghostriderfly.threaded = true 

---fuck bige.lua
