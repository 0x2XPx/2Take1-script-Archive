OwnPedd = player.get_player_ped(player.player_id())
OwnVehh = ped.get_vehicle_ped_is_using(OwnPedd)

_Version = "3.1"

notify_color1 = 4292717568
notify_color2 = 4282408703
notify_color3 = 4282442239


fuel_stations = {
       ground = {
          {v2(-70.0, -1760.0), 14.0},
          {v2(265.0, -1262.0), 19.0},
          {v2(1209.0, -1402.0), 12.0},
          {v2(1179.0, -331.0), 14.0},
          {v2(820.0, -1029.0), 12.0},
          {v2(-526.0, -1211.0), 12.0},
          {v2(-723.0, -936.0), 13.0},
          {v2(-1437.0, -277.0), 13.0},
          {v2(-2096.0, -320.0), 17.0},
          {v2(-1800.0, 803.0), 15.0},
          {v2(-2555.0, 2335.0), 13.0},
          {v2(-94.0, 6420.0), 9.0},
          {v2(179.0, 6603.0), 14.0},
          {v2(1701.0, 6416.0), 7.0},
          {v2(1688.0, 4930.0), 6.0},
          {v2(2005.0, 3774.0), 8.0},
          {v2(1786.0, 3331.0), 6.0},
          {v2(2679.0, 3264.0), 8.0},
          {v2(1207.0, 2660.0), 7.0},
          {v2(264.0, 2607.0), 7.0},
          {v2(49.0, 2779.0), 7.0},
          {v2(621.0, 269.0), 14.0},
          {v2(2582.0, 361.0), 14.0},
          {v2(2539.0, 2595.0), 5.0},
	  }
	  ,aviation = { 
	      {v2(-475.0, 5989.0), 18.0},
          {v2(2133.0, 4781.0), 9.0},
          {v2(1732.0, 3313.0), 20.0},
          {v2(-1869.0, 2801.0), 26.0},
          {v2(-2289.0, 3182.0), 19.0},
          {v2(-2120.0, 3135.0), 31.0},
          {v2(2512.0, -427.0), 14.0},
          {v2(313.0, -1465.0), 14.0},
          {v2(-721.0, -1475.0), 9.0},
          {v2(-1146.0, -2865.0), 13.0},
          {v2(-980.0, -3002.0), 33.0},
          {v2(-1220.0, -832.0), 9.0},
          {v2(-1096.0, -835.0), 9.0}  
	  }
   }  

Planes = {
    --planes
    {0xEA313705, 20000, 100},
	{0xA52F6866, 250, 2},
	{0x81BD2ED0, 1000, 3},
	{0x6CBD1D6D, 4000, 50},
	{0xFE0A508C, 20000, 50},
	{0x15F27762, 50000, 200},
	{0xD9927FE3, 2000, 10},
	{0xCA495705, 1000, 10},
	{0x39D6779E, 8000, 10},
	{0xC3F25753, 500, 10},
	{0x39D6E83F, 5000, 60},
	{0x3F119114, 40000, 200},
	{0xB39B0AE6, 5000, 50},
	{0x250B0C5E, 10000, 50},
	{0xB79F589E, 10000, 50},
	{0x97E55D11, 2000, 10},
	{0x9D80F93, 20000, 70},
	{0x5D56F01B, 5000, 50},
	{0xB2CF7250, 10000, 70},
	{0x3DC92356, 1000, 20},
	{0xAD6065C0, 1000, 40},
	{0xC5DD6967, 1000, 20},
	{0xB79C1BF5, 10000, 60},
	{0x9A9EB7DE, 1000, 60},
	{0x64DE07A1, 5000, 60},
	{0x81794C70, 2000, 20},
	{0x761E2AD3, 20000, 200},
	{0x3E2E4F8A, 15000, 120},
	{0x9C429B6A, 5000, 20},
	{0x403820E8, 5000, 20},
	{0x4FF77E37, 2000, 20},
	{0x1AAD0DED, 20000, 200}, 
	
    --helicopters
	{0x46699F47, 1000, 40},
	{0x31F0B376, 1000, 40},
	{0x31F0B376, 1000, 40},
	{0xFD707EDE, 1000, 40},
	{0xFB133A17, 1500, 50},
    {0x11962E49, 1000, 40},
	{0x2F03547B, 1000, 40},
	{0x2C75F0DD, 1000, 40},
	{0xFCFCB68B, 2000, 40},
	{0x60A7EA10, 2000, 40},
	{0x53174EEF, 2000, 40},
	{0x78BC1A3C, 2000, 40},
	{0x2C634FBD, 800, 20},
	{0x742E9AC0, 800, 20},
	{0x89BA59F5, 400, 10},
	{0x9D0450CA, 700, 20},
	{0x1517D4D9, 700, 20},
	{0xD4AE63D9, 400, 10},
	{0x494752F7, 400, 10},
	{0x5F017E6B, 400, 10},
	{0x3E48BF23, 2000, 30},
	{0x2A54C47D, 800, 30},
	{0x9C5E5644, 800, 30},
	{0xEBC24DF2, 800, 30},
	{0x4019CB4C, 800, 30},
	{0xA09E15FD, 1000, 40},
	{0x5BFA5C4B, 1000, 40},
	{0x920016F1, 800, 30}
	
}


Remove_Radius = 200
_ColorID = 110 
PTFXWait = 20
bone_index = {"exhaust", "exhaust_1", "exhaust_2", "exhaust_3", "exhaust_4", "exhaust_5"}-- Standard Bone PTFX will be attatched to
Smokes = {"bul_rubber_dust", "ent_anim_dusty_hands", "bul_gravel", "bul_gravel_heli", "exp_grd_plane_post", "bul_hay", "ent_anim_cig_exhale_mth_car"}
selectedPTFX = Smokes[1]
PTFXs ={"muz_alternate_star_fp","ent_amb_sprinkler_golf","exp_grd_molotov_lod","muz_assault_rifle","ent_brk_sparking_wires","bul_stungun_metal","veh_backfire", "ent_sht_flame","exp_grd_grenade_lod","ent_dst_gen_gobstop","bul_concrete","ent_dst_elec_fire_sp","eject_auto","fire_petroltank_car_bullet","ent_ray_train_water_wash",}
Militarypedhashs = {0xF2DAA2ED, 0x65793043, 0x72C0CAD2} -- Ped Hashs
Truckhashs = {0x21EEE87D, 0x5A82F9AE, 0x809AA4CB, 0xA90ED5C, 0x6290F15B, 0x50B0215A, 0xAF966F3C, 0x3AF8C345, 0xCE0B9F22, 0x1ED0A534}-- 1-4 Trucks, 5 pounder 6 fladbed 7 caracara 8 sandking
             EndOfTrucks = 4
TruckColorIDs = {1, 4, 5, 9, 22, 33, 32, 31, 66, 75, 134, 6, 7}
Truckerpedhashs = {0x59511A6C, 0x60D5D6DA, 0x21F58BB4, 0xD2E3A284, 0x617D89E2, 0x36E70600, 0xC8B7167D, 0xDE17DD3B, 0x696BE0A9, 0xDFE443E5} -- Truck Hashes
Flaghashs = {4182205267, 2262033332 , 1627828183, 1976910263}-- 1-2 small flags   3-end..big flags
Militarycars = {1074326203, 0xD80F4A44, 0x7B7E56F0, 0x132D5A1A, 0xCEEA3F4B, 0x2189D250, 0xD6BC7523, 0x2EA68690} --Vehicle Hashs
Policecarhashs = {2046537925, -1627000575, 1912215274,  -1683328900, 1922257928} --Police Vehicle Hashs
PoliceOfficerhashs = {0x5E3DA4A4, 0x15F8700D, 0x739B1EF5}

--[[
menu.add_feature("Sound", "action", Vehicles, function(feat)
audio.play_sound_from_entity(-1, "ATM_WINDOW" , player.get_player_ped(player.player_id()), "HUD_FRONTEND_DEFAULT_SOUNDSET")
end)
menu.add_feature("Sound", "action", Vehicles, function(feat)
audio.play_sound_from_entity(-1, "5_SEC_WARNING" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
end)
menu.add_feature("Sound", "action", Vehicles, function(feat)
audio.play_sound_from_entity(-1, "CHECKPOINT_MISSED" , player.get_player_ped(player.player_id()), "HUD_MINI_GAME_SOUNDSET")
end)
menu.add_feature("Sound", "action", Vehicles, function(feat)
audio.play_sound_from_entity(-1, "Menu_Accept" , player.get_player_ped(player.player_id()), "Phone_SoundSet_Default")
end)
menu.add_feature("Sound", "action", Vehicles, function(feat)
audio.play_sound_from_entity(-1, "MP_IDLE_TIMER" , player.get_player_ped(player.player_id()), "HUD_FRONTEND_DEFAULT_SOUNDSET")
end)
menu.add_feature("Sound", "action", Vehicles, function(feat)
end)
--]]

--[[
Vehicle_types = {
    Suv = {},
    Sports = {},
	Planes = {0xEA313705 }
} 
--]]

--{hex, tankvolume, verbrauchsfaktor},

--Messfeature messreihe aufnehmen durchschnitt speed verbrauch.......


function round(number, decimalplaces)
   local mult = 10^(decimalplaces or 0)
   return math.floor(number * mult + 0.5) / mult
end

--[[
a = 1
menu.add_feature("print coords", "action", fuel_consumption, function()
if a==1 then
   poos = {}
end
  poos[a] = entity.get_entity_coords(OwnPedd)
  a = a + 1
  if (a == 3) then
      a = 1
      print("{v2("..round(poos[1].x, 1)..", "..round(poos[1].y, 1).."), v2("..round(poos[2].x, 1)..", "..round(poos[2].y, 1)..")}," )
          fuel_blips = ui.add_blip_for_coord(v3(poos[1].x, poos[1].y, 0))
          ui.set_blip_sprite(fuel_blips, 361)
          ui.set_blip_colour(fuel_blips, 17)
  end

end)


a = 1
menu.add_feature("print coords and radius", "action", fuel_consumption, function()
if a==1 then
   poos = {}
end
  pos = entity.get_entity_coords(OwnPedd)
  poos[a] = v3(pos.x, pos.y, 0)
  a = a + 1
  if (a == 3) then
      a = 1
	  c = v3(poos[1].x - poos[2].x, poos[1].y - poos[2].y, 0)
	  radius = vector_amount(c)
	  print("{v2("..round(poos[1].x, 0)..", "..round(poos[1].y, 0).."), "..round(radius, 0).."},")
          fuel_blips = ui.add_blip_for_coord(v3(poos[1].x, poos[1].y, 0))
          ui.set_blip_sprite(fuel_blips, 361)
          ui.set_blip_colour(fuel_blips, 17)
  end

end)
--]]
 