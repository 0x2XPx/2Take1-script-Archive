if modLoaded then
	ui.notify_above_map("iplLoader is already loaded.", "iplLoader", 140)
	return
end
modLoaded = true


function teleportHome()
	entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-63.477, -786.490, 44.227))
	return HANDLER_POP
end

--[[ - SoonTM This still needs work.
function unLoadAll()
	local iplList = {"sunkcargoship","SUNK_SHIP_FIRE","cargoship","coronertrash","Coroner_Int_On","vw_casino_main﻿","vw_casino_garage","vw_casino_carpark","vw_casino_penthouse","DES_StiltHouse_imapend","DES_stilthouse_rebuild","SP1_10_real_interior","refit_unload","post_hiest_unload","FIBlobby","TrevorsMP","TrevorsTrailerTidy","hei_yacht_heist","hei_yacht_heist_enginrm","hei_yacht_heist_Lounge","hei_yacht_heist_Bridge","hei_yacht_heist_Bar","hei_yacht_heist_Bedrm","hei_yacht_heist_DistantLights","hei_yacht_heist_LODLights","smboat","smboat_lod","canyonriver01","railing_start","canyonriver01_traincrash","railing_end","farmint","farm_burnt","farm_burnt_props","des_farmhs_endimap","des_farmhs_end_occl","farm","farm_props","farm_int","farmint","farm_burnt","farm_burnt_props","des_farmhs_endimap","des_farmhs_end_occl","farm","farm_props","farm_int"}
		for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end
]]--

function defaultCargoship()
	streaming.remove_ipl("sunkcargoship")
	streaming.remove_ipl("SUNK_SHIP_FIRE")
	streaming.request_ipl("cargoship")
	return HANDLER_POP
end

function sunkenCargoship()
	streaming.remove_ipl("cargoship")
	streaming.request_ipl("sunkcargoship")
	streaming.request_ipl("SUNK_SHIP_FIRE")
	return HANDLER_POP
end

function tpCargoship()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(-163.3628, -2385.161, 5.999994)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function loadMorgue()
	local iplList = {"coronertrash","Coroner_Int_On"}
		for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadMorgue()
	local iplList = {"coronertrash","Coroner_Int_On"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function tpMorgue()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(275.446, -1361.11, 24.5378)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function LoadCasino()
	local iplList = {"vw_casino_main﻿","hei_dlc_casino_door","vw_dlc_casino_door"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function tpCasino()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(1109.996, 222.625, -49.841)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
		system.wait(100)
		entity.set_entity_coords_no_offset(vehicle, position)
		system.wait(1000)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
		system.wait(100)
		entity.set_entity_coords_no_offset(player, position)
		system.wait(1000)
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function LoadPenthouse()
	local iplList = {"vw_casino_penthouse","hei_dlc_windows_casino"}
	--local intLocation = interior.get_interior_at_coords_with_type(v3(976.636, 70.295, 116.160),1)
	--local intList = {"Set_Pent_Tint_Shell","Set_Pent_Pattern_01","Set_Pent_Spa_Bar_Open","Set_Pent_Media_Bar_Open","Set_Pent_Dealer","Set_Pent_Arcade_Modern","Set_Pent_Bar_Clutter","set_pent_bar_light_0"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	--interior.enable_interior_prop(intLocation, "Set_Pent_Tint_Shell") -- @Sub please add INTERIOR::GET_INTERIOR_AT_COORDS()
	--[[for i, props in ipairs(intList) do
		interior.enable_interior_prop(intLocation, props)
	end]]--
	return HANDLER_POP
end

function unLoadPenthouse()
	local iplList = {"vw_casino_penthouse","hei_dlc_windows_casino"}
	local intLocation = interior.get_interior_at_coords_with_type(v3(976.636, 70.295, 116.160),0)
	local intList = {"Set_Pent_Tint_Shell","Set_Pent_Pattern_01","Set_Pent_Spa_Bar_Open","Set_Pent_Media_Bar_Open","Set_Pent_Dealer","Set_Pent_Arcade_Modern","Set_Pent_Bar_Clutter","set_pent_bar_light_0"}
	local iplList = {"vw_casino_penthouse","hei_dlc_windows_casino"}
	local interiorList = {""}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	for i, props in ipairs(intList) do
		interior.disable_interior_prop(intLocation, props)
	end
	return HANDLER_POP
end

function tpPenthouse()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(976.636, 70.295, 116.160)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function LoadCasinoGarage()
	local iplList = {"vw_casino_garage"}
	local interiorList = {""}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadCasinoGarage()
	local iplList = {"vw_casino_garage"}
	local interiorList = {""}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function tpCasinoGarage()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(1295.000, 230.000, -49.058)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function LoadCasinoCarPark()
	local iplList = {"vw_casino_carpark"}
	local interiorList = {""}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadCasinoCarPark()
	local iplList = {"vw_casino_carpark"}
	local interiorList = {""}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function tpCasinoCarPark()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(1380.000, 200.000, -49.058)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function rebuildStilt()
	streaming.remove_ipl("DES_StiltHouse_imapend")
	streaming.request_ipl("DES_stilthouse_rebuild")
	return HANDLER_POP
end

function brokenStilt()
	streaming.remove_ipl("DES_stilthouse_rebuild")
	streaming.request_ipl("DES_StiltHouse_imapend")
	return HANDLER_POP
end

function tpStilt()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(-984.259, 661.130, 165.664)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function loadStadium()
	local iplList = {"SP1_10_real_interior"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadStadium()
	local iplList = {"SP1_10_real_interior"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function tpStadium()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(-248.6731, -2010.603, 30.14562)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function loadRenda()
	local iplList = {"refit_unload"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadRenda()
	local iplList = {"refit_unload"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function tpRenda()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(-585.8247, -282.72, 35.45475)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function loadJewel()
	local iplList = {"bh1_16_refurb","jewel2fake"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	local iplList = {"post_hiest_unload"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadJewel()
	local iplList = {"post_hiest_unload"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	local iplList = {"jewel2fake"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function tpJewel()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(-630.07, -236.332, 38.05704)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function loadFIB()
	local iplList = {"FIBlobby"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadFIB()
	local iplList = {"FIBlobby"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function tpFIB()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(110.4, -744.2, 45.7496)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function cleanTrailer()
	streaming.remove_ipl("TrevorsMP")
	streaming.request_ipl("TrevorsTrailerTidy")
	system.wait(50)
	entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(1975.552, 3820.538, 33.44833))
	return HANDLER_POP
end

function dirtyTrailer()
	streaming.remove_ipl("TrevorsTrailerTidy")
	streaming.request_ipl("TrevorsMP")
	system.wait(50)
	entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(1975.552, 3820.538, 33.44833))
	return HANDLER_POP
end

function tpTrailer()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(1975.552, 3820.538, 33.44833)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function heistYacht()
	local iplList = {"hei_yacht_heist","hei_yacht_heist_enginrm","hei_yacht_heist_Lounge","hei_yacht_heist_Bridge","hei_yacht_heist_Bar","hei_yacht_heist_Bedrm","hei_yacht_heist_DistantLights","hei_yacht_heist_LODLights"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	local iplList = {"smboat","smboat_lod"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function partyYacht()
	local iplList = {"smboat","smboat_lod"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	local iplList = {"hei_yacht_heist","hei_yacht_heist_enginrm","hei_yacht_heist_Lounge","hei_yacht_heist_Bridge","hei_yacht_heist_Bar","hei_yacht_heist_Bedrm","hei_yacht_heist_DistantLights","hei_yacht_heist_LODLights"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadYacht()
	local iplList = {"hei_yacht_heist","hei_yacht_heist_enginrm","hei_yacht_heist_Lounge","hei_yacht_heist_Bridge","hei_yacht_heist_Bar","hei_yacht_heist_Bedrm","hei_yacht_heist_DistantLights","hei_yacht_heist_LODLights","smboat","smboat_lod"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function tpYacht()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(-2027.946, -1036.695, 6.707587)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function loadTrain()
	local iplList = {"canyonriver01","railing_start"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	local iplList = {"canyonriver01_traincrash","railing_end"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadTrain()
	local iplList = {"canyonriver01_traincrash","railing_end"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	local iplList = {"canyonriver01","railing_start"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function tpTrain()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(-532.1309, 4526.187, 89.79387)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function burningFarm()
	local iplList = {"farm","farm_props","farmint","farmint_cap","farm_burnt","farm_burnt_props","des_farmhouse","des_farmhs_endimap","des_farmhs_startimap","des_farmhs_end_occl","des_farmhs_start_occl"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	local iplList = {"farm","des_farmhouse","des_farmhs_endimap","des_farmhs_startimap","des_farmhs_end_occl","des_farmhs_start_occl"}
	--local iplList = {"farmint","farm_burnt","farm_burnt_props","des_farmhs_endimap"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function burnedFarm()
	local iplList = {"farm","farm_props","farmint","farmint_cap","farm_burnt","farm_burnt_props","des_farmhouse","des_farmhs_endimap","des_farmhs_startimap","des_farmhs_end_occl","des_farmhs_start_occl"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	local iplList = {"farm_burnt","farm_burnt_props"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function normalFarm()
	local iplList = {"farm","farm_props","farmint","farmint_cap","farm_burnt","farm_burnt_props","des_farmhouse","des_farmhs_endimap","des_farmhs_startimap","des_farmhs_end_occl","des_farmhs_start_occl"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	local iplList = {"farm","farm_props","farmint","farmint_cap","des_farmhouse"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function tpFarm()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(2469.03, 4955.278, 45.11892)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function loadChicken()
	local iplList = {"cs1_02_cf_onmission1","cs1_02_cf_onmission2","cs1_02_cf_onmission3","cs1_02_cf_onmission4"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadChicken()
	local iplList = {"cs1_02_cf_onmission1","cs1_02_cf_onmission2","cs1_02_cf_onmission3","cs1_02_cf_onmission4"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function tpChicken()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(-74.635, 6239.129, 31.082)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function loadCargoPlane()
	local iplList = {"crashed_cargoplane"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadCargoPlane()
	local iplList = {"crashed_cargoplane"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function tpCargoPlane()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(300.705139, 3979.68262, 3.044629)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function loadYankton()
	local iplList = {"prologue01","prologue01c","prologue01d","prologue01e","prologue01f","prologue01g","prologue01h","prologue01i","prologue01j","prologue01k","prologue01z","prologue02","prologue03","prologue03b","prologue03_grv_dug","prologue_grv_torch","prologue04","prologue04b","prologue04_cover","des_protree_end","des_protree_start","prologue05","prologue05b","prologue06","prologue06b","prologue06b_int","prologue06b_pannel","plg_occl_00","prologue_occl","prologuerd","prologuerdb"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	ui.notify_above_map("North Yankton Loaded.", "iplLoader", 140)
	return HANDLER_POP
end

function unLoadYankton()
	local iplList = {"prologue01","prologue01c","prologue01d","prologue01e","prologue01f","prologue01g","prologue01h","prologue01i","prologue01j","prologue01k","prologue01z","prologue02","prologue03","prologue03b","prologue03_grv_dug","prologue_grv_torch","prologue04","prologue04b","prologue04_cover","des_protree_end","des_protree_start","prologue05","prologue05b","prologue06","prologue06b","prologue06b_int","prologue06b_pannel","plg_occl_00","prologue_occl","prologuerd","prologuerdb"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	ui.notify_above_map("North Yankton Unloaded.", "iplLoader", 140)
	return HANDLER_POP
end

function tpYankton()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(3217.697, -4834.826, 111.8152)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function loadUFO()
	local iplList = {"ufo_eye"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadUFO()
	local iplList = {"ufo_eye"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function tpUFO()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(501.729, 5603.795, 797.910)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function loadRed()
	local iplList = {"redcarpet"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadRed()
	local iplList = {"redcarpet"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function tpRed()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(294.651855, 189.581818, 105.084229)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function loadFace()
	local iplList = {"facelobby"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	return HANDLER_POP
end

function unLoadFace()
	local iplList = {"facelobby"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	return HANDLER_POP
end

function tpFace()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(-1083.737, -254.300, 37.763)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function loadIsland()
	local iplList = {"h4_mph4_terrain_occ_09","h4_mph4_terrain_occ_06","h4_mph4_terrain_occ_05","h4_mph4_terrain_occ_01","h4_mph4_terrain_occ_00","h4_mph4_terrain_occ_08","h4_mph4_terrain_occ_04","h4_mph4_terrain_occ_07","h4_mph4_terrain_occ_03","h4_mph4_terrain_occ_02","h4_islandx_terrain_04","h4_islandx_terrain_05_slod","h4_islandx_terrain_props_05_d_slod","h4_islandx_terrain_02","h4_islandx_terrain_props_05_a_lod","h4_islandx_terrain_props_05_c_lod","h4_islandx_terrain_01","h4_mph4_terrain_04","h4_mph4_terrain_06","h4_islandx_terrain_04_lod","h4_islandx_terrain_03_lod","h4_islandx_terrain_props_06_a","h4_islandx_terrain_props_06_a_slod","h4_islandx_terrain_props_05_f_lod","h4_islandx_terrain_props_06_b","h4_islandx_terrain_props_05_b_lod","h4_mph4_terrain_lod","h4_islandx_terrain_props_05_e_lod","h4_islandx_terrain_05_lod","h4_mph4_terrain_02","h4_islandx_terrain_props_05_a","h4_mph4_terrain_01_long_0","h4_islandx_terrain_03","h4_islandx_terrain_props_06_b_slod","h4_islandx_terrain_01_slod","h4_islandx_terrain_04_slod","h4_islandx_terrain_props_05_d_lod","h4_islandx_terrain_props_05_f_slod","h4_islandx_terrain_props_05_c","h4_islandx_terrain_02_lod","h4_islandx_terrain_06_slod","h4_islandx_terrain_props_06_c_slod","h4_islandx_terrain_props_06_c","h4_islandx_terrain_01_lod","h4_mph4_terrain_06_strm_0","h4_islandx_terrain_05","h4_islandx_terrain_props_05_e_slod","h4_islandx_terrain_props_06_c_lod","h4_mph4_terrain_03","h4_islandx_terrain_props_05_f","h4_islandx_terrain_06_lod","h4_mph4_terrain_01","h4_islandx_terrain_06","h4_islandx_terrain_props_06_a_lod","h4_islandx_terrain_props_06_b_lod","h4_islandx_terrain_props_05_b","h4_islandx_terrain_02_slod","h4_islandx_terrain_props_05_e","h4_islandx_terrain_props_05_d","h4_mph4_terrain_05","h4_mph4_terrain_02_grass_2","h4_mph4_terrain_01_grass_1","h4_mph4_terrain_05_grass_0","h4_mph4_terrain_01_grass_0","h4_mph4_terrain_02_grass_1","h4_mph4_terrain_02_grass_0","h4_mph4_terrain_02_grass_3","h4_mph4_terrain_04_grass_0","h4_mph4_terrain_06_grass_0","h4_mph4_terrain_04_grass_1","island_distantlights","island_lodlights","h4_yacht_strm_0","h4_yacht","h4_yacht_long_0","h4_islandx_yacht_01_lod","h4_clubposter_palmstraxx","h4_islandx_yacht_02_int","h4_islandx_yacht_02","h4_clubposter_moodymann","h4_islandx_yacht_01","h4_clubposter_keinemusik","h4_islandx_yacht_03","h4_ch2_mansion_final","h4_islandx_yacht_03_int","h4_yacht_critical_0","h4_islandx_yacht_01_int","h4_mph4_island_placement","h4_islandx_mansion_vault","h4_islandx_checkpoint_props","h4_islandairstrip_hangar_props_slod","h4_se_ipl_01_lod","h4_ne_ipl_00_slod","h4_se_ipl_06_slod","h4_ne_ipl_00","h4_se_ipl_02","h4_islandx_barrack_props_lod","h4_se_ipl_09_lod","h4_ne_ipl_05","h4_mph4_island_se_placement","h4_ne_ipl_09","h4_islandx_mansion_props_slod","h4_se_ipl_09","h4_mph4_mansion_b","h4_islandairstrip_hangar_props_lod","h4_islandx_mansion_entrance_fence","h4_nw_ipl_09","h4_nw_ipl_02_lod","h4_ne_ipl_09_slod","h4_sw_ipl_02","h4_islandx_checkpoint","h4_islandxdock_water_hatch","h4_nw_ipl_04_lod","h4_islandx_maindock_props","h4_beach","h4_islandx_mansion_lockup_03_lod","h4_ne_ipl_04_slod","h4_mph4_island_nw_placement","h4_ne_ipl_08_slod","h4_nw_ipl_09_lod","h4_se_ipl_08_lod","h4_islandx_maindock_props_lod","h4_se_ipl_03","h4_sw_ipl_02_slod","h4_nw_ipl_00","h4_islandx_mansion_b_side_fence","h4_ne_ipl_01_lod","h4_se_ipl_06_lod","h4_ne_ipl_03","h4_islandx_maindock","h4_se_ipl_01","h4_sw_ipl_07","h4_islandx_maindock_props_2","h4_islandxtower_veg","h4_mph4_island_sw_placement","h4_se_ipl_01_slod","h4_mph4_wtowers","h4_se_ipl_02_lod","h4_islandx_mansion","h4_nw_ipl_04","h4_mph4_airstrip_interior_0_airstrip_hanger","h4_islandx_mansion_lockup_01","h4_islandx_barrack_props","h4_nw_ipl_07_lod","h4_nw_ipl_00_slod","h4_sw_ipl_08_lod","h4_islandxdock_props_slod","h4_islandx_mansion_lockup_02","h4_islandx_mansion_slod","h4_sw_ipl_07_lod","h4_islandairstrip_doorsclosed_lod","h4_sw_ipl_02_lod","h4_se_ipl_04_slod","h4_islandx_checkpoint_props_lod","h4_se_ipl_04","h4_se_ipl_07","h4_mph4_mansion_b_strm_0","h4_nw_ipl_09_slod","h4_se_ipl_07_lod","h4_islandx_maindock_slod","h4_islandx_mansion_lod","h4_sw_ipl_05_lod","h4_nw_ipl_08","h4_islandairstrip_slod","h4_nw_ipl_07","h4_islandairstrip_propsb_lod","h4_islandx_checkpoint_props_slod","h4_aa_guns_lod","h4_sw_ipl_06","h4_islandx_maindock_props_2_slod","h4_islandx_mansion_office","h4_islandx_maindock_lod","h4_mph4_dock","h4_islandairstrip_propsb","h4_islandx_mansion_lockup_03","h4_nw_ipl_01_lod","h4_se_ipl_05_slod","h4_sw_ipl_01_lod","h4_nw_ipl_05","h4_islandxdock_props_2_lod","h4_ne_ipl_04_lod","h4_ne_ipl_01","h4_beach_party_lod","h4_islandx_mansion_lights","h4_sw_ipl_00_lod","h4_islandx_mansion_guardfence","h4_beach_props_party","h4_ne_ipl_03_lod","h4_islandx_mansion_b","h4_beach_bar_props","h4_ne_ipl_04","h4_sw_ipl_08_slod","h4_islandxtower","h4_se_ipl_00_slod","h4_islandx_barrack_hatch","h4_ne_ipl_06_slod","h4_ne_ipl_03_slod","h4_sw_ipl_09_slod","h4_ne_ipl_02_slod","h4_nw_ipl_04_slod","h4_ne_ipl_05_lod","h4_nw_ipl_08_slod","h4_sw_ipl_05_slod","h4_islandx_mansion_b_lod","h4_ne_ipl_08","h4_islandxdock_props","h4_islandairstrip_doorsopen_lod","h4_se_ipl_05_lod","h4_islandxcanal_props_slod","h4_mansion_gate_closed","h4_se_ipl_02_slod","h4_nw_ipl_02","h4_ne_ipl_08_lod","h4_sw_ipl_08","h4_islandairstrip","h4_islandairstrip_props_lod","h4_se_ipl_05","h4_ne_ipl_02_lod","h4_islandx_maindock_props_2_lod","h4_sw_ipl_03_slod","h4_ne_ipl_01_slod","h4_beach_props_slod","h4_underwater_gate_closed","h4_ne_ipl_00_lod","h4_islandairstrip_doorsopen","h4_sw_ipl_01_slod","h4_se_ipl_00","h4_se_ipl_06","h4_islandx_mansion_lockup_02_lod","h4_islandxtower_veg_lod","h4_sw_ipl_00","h4_se_ipl_04_lod","h4_nw_ipl_07_slod","h4_islandx_mansion_props_lod","h4_islandairstrip_hangar_props","h4_nw_ipl_06_lod","h4_islandxtower_lod","h4_islandxdock_lod","h4_islandxdock_props_lod","h4_beach_party","h4_nw_ipl_06_slod","h4_islandairstrip_doorsclosed","h4_nw_ipl_00_lod","h4_ne_ipl_02","h4_islandxdock_slod","h4_se_ipl_07_slod","h4_islandxdock","h4_islandxdock_props_2_slod","h4_islandairstrip_props","h4_sw_ipl_09","h4_ne_ipl_06","h4_se_ipl_03_lod","h4_nw_ipl_03","h4_islandx_mansion_lockup_01_lod","h4_beach_lod","h4_ne_ipl_07_lod","h4_nw_ipl_01","h4_mph4_island_lod","h4_islandx_mansion_office_lod","h4_islandairstrip_lod","h4_beach_props_lod","h4_nw_ipl_05_slod","h4_islandx_checkpoint_lod","h4_nw_ipl_05_lod","h4_nw_ipl_03_slod","h4_nw_ipl_03_lod","h4_sw_ipl_05","h4_mph4_mansion","h4_sw_ipl_03","h4_se_ipl_08_slod","h4_mph4_island_ne_placement","h4_aa_guns","h4_islandairstrip_propsb_slod","h4_sw_ipl_01","h4_mansion_remains_cage","h4_nw_ipl_01_slod","h4_ne_ipl_06_lod","h4_se_ipl_08","h4_sw_ipl_04_slod","h4_sw_ipl_04_lod","h4_mph4_beach","h4_sw_ipl_06_lod","h4_sw_ipl_06_slod","h4_se_ipl_00_lod","h4_ne_ipl_07_slod","h4_mph4_mansion_strm_0","h4_nw_ipl_02_slod","h4_mph4_airstrip","h4_island_padlock_props","h4_islandairstrip_props_slod","h4_nw_ipl_06","h4_sw_ipl_09_lod","h4_islandxcanal_props_lod","h4_ne_ipl_05_slod","h4_se_ipl_09_slod","h4_islandx_mansion_vault_lod","h4_se_ipl_03_slod","h4_nw_ipl_08_lod","h4_islandx_barrack_props_slod","h4_islandxtower_veg_slod","h4_sw_ipl_04","h4_islandx_mansion_props","h4_islandxtower_slod","h4_beach_props","h4_islandx_mansion_b_slod","h4_islandx_maindock_props_slod","h4_sw_ipl_07_slod","h4_ne_ipl_07","h4_islandxdock_props_2","h4_ne_ipl_09_lod","h4_islandxcanal_props","h4_beach_slod","h4_sw_ipl_00_slod","h4_sw_ipl_03_lod","h4_islandx_disc_strandedshark","h4_islandx_disc_strandedshark_lod","h4_islandx","h4_islandx_props_lod","h4_mph4_island_strm_0","h4_islandx_sea_mines","h4_mph4_island","h4_boatblockers","h4_mph4_island_long_0","h4_islandx_disc_strandedwhale","h4_islandx_disc_strandedwhale_lod","h4_islandx_props","h4_int_placement_h4_interior_1_dlc_int_02_h4_milo_","h4_int_placement_h4_interior_0_int_sub_h4_milo_","h4_int_placement_h4"}
	for i, ipl in ipairs(iplList) do
		streaming.request_ipl(ipl)
	end
	ui.notify_above_map("Cayo Island Loaded.", "iplLoader", 140)
	return HANDLER_POP
end

function unLoadIsland()
	local iplList = {"h4_mph4_terrain_occ_09","h4_mph4_terrain_occ_06","h4_mph4_terrain_occ_05","h4_mph4_terrain_occ_01","h4_mph4_terrain_occ_00","h4_mph4_terrain_occ_08","h4_mph4_terrain_occ_04","h4_mph4_terrain_occ_07","h4_mph4_terrain_occ_03","h4_mph4_terrain_occ_02","h4_islandx_terrain_04","h4_islandx_terrain_05_slod","h4_islandx_terrain_props_05_d_slod","h4_islandx_terrain_02","h4_islandx_terrain_props_05_a_lod","h4_islandx_terrain_props_05_c_lod","h4_islandx_terrain_01","h4_mph4_terrain_04","h4_mph4_terrain_06","h4_islandx_terrain_04_lod","h4_islandx_terrain_03_lod","h4_islandx_terrain_props_06_a","h4_islandx_terrain_props_06_a_slod","h4_islandx_terrain_props_05_f_lod","h4_islandx_terrain_props_06_b","h4_islandx_terrain_props_05_b_lod","h4_mph4_terrain_lod","h4_islandx_terrain_props_05_e_lod","h4_islandx_terrain_05_lod","h4_mph4_terrain_02","h4_islandx_terrain_props_05_a","h4_mph4_terrain_01_long_0","h4_islandx_terrain_03","h4_islandx_terrain_props_06_b_slod","h4_islandx_terrain_01_slod","h4_islandx_terrain_04_slod","h4_islandx_terrain_props_05_d_lod","h4_islandx_terrain_props_05_f_slod","h4_islandx_terrain_props_05_c","h4_islandx_terrain_02_lod","h4_islandx_terrain_06_slod","h4_islandx_terrain_props_06_c_slod","h4_islandx_terrain_props_06_c","h4_islandx_terrain_01_lod","h4_mph4_terrain_06_strm_0","h4_islandx_terrain_05","h4_islandx_terrain_props_05_e_slod","h4_islandx_terrain_props_06_c_lod","h4_mph4_terrain_03","h4_islandx_terrain_props_05_f","h4_islandx_terrain_06_lod","h4_mph4_terrain_01","h4_islandx_terrain_06","h4_islandx_terrain_props_06_a_lod","h4_islandx_terrain_props_06_b_lod","h4_islandx_terrain_props_05_b","h4_islandx_terrain_02_slod","h4_islandx_terrain_props_05_e","h4_islandx_terrain_props_05_d","h4_mph4_terrain_05","h4_mph4_terrain_02_grass_2","h4_mph4_terrain_01_grass_1","h4_mph4_terrain_05_grass_0","h4_mph4_terrain_01_grass_0","h4_mph4_terrain_02_grass_1","h4_mph4_terrain_02_grass_0","h4_mph4_terrain_02_grass_3","h4_mph4_terrain_04_grass_0","h4_mph4_terrain_06_grass_0","h4_mph4_terrain_04_grass_1","island_distantlights","island_lodlights","h4_yacht_strm_0","h4_yacht","h4_yacht_long_0","h4_islandx_yacht_01_lod","h4_clubposter_palmstraxx","h4_islandx_yacht_02_int","h4_islandx_yacht_02","h4_clubposter_moodymann","h4_islandx_yacht_01","h4_clubposter_keinemusik","h4_islandx_yacht_03","h4_ch2_mansion_final","h4_islandx_yacht_03_int","h4_yacht_critical_0","h4_islandx_yacht_01_int","h4_mph4_island_placement","h4_islandx_mansion_vault","h4_islandx_checkpoint_props","h4_islandairstrip_hangar_props_slod","h4_se_ipl_01_lod","h4_ne_ipl_00_slod","h4_se_ipl_06_slod","h4_ne_ipl_00","h4_se_ipl_02","h4_islandx_barrack_props_lod","h4_se_ipl_09_lod","h4_ne_ipl_05","h4_mph4_island_se_placement","h4_ne_ipl_09","h4_islandx_mansion_props_slod","h4_se_ipl_09","h4_mph4_mansion_b","h4_islandairstrip_hangar_props_lod","h4_islandx_mansion_entrance_fence","h4_nw_ipl_09","h4_nw_ipl_02_lod","h4_ne_ipl_09_slod","h4_sw_ipl_02","h4_islandx_checkpoint","h4_islandxdock_water_hatch","h4_nw_ipl_04_lod","h4_islandx_maindock_props","h4_beach","h4_islandx_mansion_lockup_03_lod","h4_ne_ipl_04_slod","h4_mph4_island_nw_placement","h4_ne_ipl_08_slod","h4_nw_ipl_09_lod","h4_se_ipl_08_lod","h4_islandx_maindock_props_lod","h4_se_ipl_03","h4_sw_ipl_02_slod","h4_nw_ipl_00","h4_islandx_mansion_b_side_fence","h4_ne_ipl_01_lod","h4_se_ipl_06_lod","h4_ne_ipl_03","h4_islandx_maindock","h4_se_ipl_01","h4_sw_ipl_07","h4_islandx_maindock_props_2","h4_islandxtower_veg","h4_mph4_island_sw_placement","h4_se_ipl_01_slod","h4_mph4_wtowers","h4_se_ipl_02_lod","h4_islandx_mansion","h4_nw_ipl_04","h4_mph4_airstrip_interior_0_airstrip_hanger","h4_islandx_mansion_lockup_01","h4_islandx_barrack_props","h4_nw_ipl_07_lod","h4_nw_ipl_00_slod","h4_sw_ipl_08_lod","h4_islandxdock_props_slod","h4_islandx_mansion_lockup_02","h4_islandx_mansion_slod","h4_sw_ipl_07_lod","h4_islandairstrip_doorsclosed_lod","h4_sw_ipl_02_lod","h4_se_ipl_04_slod","h4_islandx_checkpoint_props_lod","h4_se_ipl_04","h4_se_ipl_07","h4_mph4_mansion_b_strm_0","h4_nw_ipl_09_slod","h4_se_ipl_07_lod","h4_islandx_maindock_slod","h4_islandx_mansion_lod","h4_sw_ipl_05_lod","h4_nw_ipl_08","h4_islandairstrip_slod","h4_nw_ipl_07","h4_islandairstrip_propsb_lod","h4_islandx_checkpoint_props_slod","h4_aa_guns_lod","h4_sw_ipl_06","h4_islandx_maindock_props_2_slod","h4_islandx_mansion_office","h4_islandx_maindock_lod","h4_mph4_dock","h4_islandairstrip_propsb","h4_islandx_mansion_lockup_03","h4_nw_ipl_01_lod","h4_se_ipl_05_slod","h4_sw_ipl_01_lod","h4_nw_ipl_05","h4_islandxdock_props_2_lod","h4_ne_ipl_04_lod","h4_ne_ipl_01","h4_beach_party_lod","h4_islandx_mansion_lights","h4_sw_ipl_00_lod","h4_islandx_mansion_guardfence","h4_beach_props_party","h4_ne_ipl_03_lod","h4_islandx_mansion_b","h4_beach_bar_props","h4_ne_ipl_04","h4_sw_ipl_08_slod","h4_islandxtower","h4_se_ipl_00_slod","h4_islandx_barrack_hatch","h4_ne_ipl_06_slod","h4_ne_ipl_03_slod","h4_sw_ipl_09_slod","h4_ne_ipl_02_slod","h4_nw_ipl_04_slod","h4_ne_ipl_05_lod","h4_nw_ipl_08_slod","h4_sw_ipl_05_slod","h4_islandx_mansion_b_lod","h4_ne_ipl_08","h4_islandxdock_props","h4_islandairstrip_doorsopen_lod","h4_se_ipl_05_lod","h4_islandxcanal_props_slod","h4_mansion_gate_closed","h4_se_ipl_02_slod","h4_nw_ipl_02","h4_ne_ipl_08_lod","h4_sw_ipl_08","h4_islandairstrip","h4_islandairstrip_props_lod","h4_se_ipl_05","h4_ne_ipl_02_lod","h4_islandx_maindock_props_2_lod","h4_sw_ipl_03_slod","h4_ne_ipl_01_slod","h4_beach_props_slod","h4_underwater_gate_closed","h4_ne_ipl_00_lod","h4_islandairstrip_doorsopen","h4_sw_ipl_01_slod","h4_se_ipl_00","h4_se_ipl_06","h4_islandx_mansion_lockup_02_lod","h4_islandxtower_veg_lod","h4_sw_ipl_00","h4_se_ipl_04_lod","h4_nw_ipl_07_slod","h4_islandx_mansion_props_lod","h4_islandairstrip_hangar_props","h4_nw_ipl_06_lod","h4_islandxtower_lod","h4_islandxdock_lod","h4_islandxdock_props_lod","h4_beach_party","h4_nw_ipl_06_slod","h4_islandairstrip_doorsclosed","h4_nw_ipl_00_lod","h4_ne_ipl_02","h4_islandxdock_slod","h4_se_ipl_07_slod","h4_islandxdock","h4_islandxdock_props_2_slod","h4_islandairstrip_props","h4_sw_ipl_09","h4_ne_ipl_06","h4_se_ipl_03_lod","h4_nw_ipl_03","h4_islandx_mansion_lockup_01_lod","h4_beach_lod","h4_ne_ipl_07_lod","h4_nw_ipl_01","h4_mph4_island_lod","h4_islandx_mansion_office_lod","h4_islandairstrip_lod","h4_beach_props_lod","h4_nw_ipl_05_slod","h4_islandx_checkpoint_lod","h4_nw_ipl_05_lod","h4_nw_ipl_03_slod","h4_nw_ipl_03_lod","h4_sw_ipl_05","h4_mph4_mansion","h4_sw_ipl_03","h4_se_ipl_08_slod","h4_mph4_island_ne_placement","h4_aa_guns","h4_islandairstrip_propsb_slod","h4_sw_ipl_01","h4_mansion_remains_cage","h4_nw_ipl_01_slod","h4_ne_ipl_06_lod","h4_se_ipl_08","h4_sw_ipl_04_slod","h4_sw_ipl_04_lod","h4_mph4_beach","h4_sw_ipl_06_lod","h4_sw_ipl_06_slod","h4_se_ipl_00_lod","h4_ne_ipl_07_slod","h4_mph4_mansion_strm_0","h4_nw_ipl_02_slod","h4_mph4_airstrip","h4_island_padlock_props","h4_islandairstrip_props_slod","h4_nw_ipl_06","h4_sw_ipl_09_lod","h4_islandxcanal_props_lod","h4_ne_ipl_05_slod","h4_se_ipl_09_slod","h4_islandx_mansion_vault_lod","h4_se_ipl_03_slod","h4_nw_ipl_08_lod","h4_islandx_barrack_props_slod","h4_islandxtower_veg_slod","h4_sw_ipl_04","h4_islandx_mansion_props","h4_islandxtower_slod","h4_beach_props","h4_islandx_mansion_b_slod","h4_islandx_maindock_props_slod","h4_sw_ipl_07_slod","h4_ne_ipl_07","h4_islandxdock_props_2","h4_ne_ipl_09_lod","h4_islandxcanal_props","h4_beach_slod","h4_sw_ipl_00_slod","h4_sw_ipl_03_lod","h4_islandx_disc_strandedshark","h4_islandx_disc_strandedshark_lod","h4_islandx","h4_islandx_props_lod","h4_mph4_island_strm_0","h4_islandx_sea_mines","h4_mph4_island","h4_boatblockers","h4_mph4_island_long_0","h4_islandx_disc_strandedwhale","h4_islandx_disc_strandedwhale_lod","h4_islandx_props","h4_int_placement_h4_interior_1_dlc_int_02_h4_milo_","h4_int_placement_h4_interior_0_int_sub_h4_milo_","h4_int_placement_h4"}
	for i, ipl in ipairs(iplList) do
		streaming.remove_ipl(ipl)
	end
	ui.notify_above_map("Cayo Island Unloaded.", "iplLoader", 140)
	return HANDLER_POP
end

function tpIslandAirport()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(4445.811, -4510.292, 4.184)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function tpIslandParty()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(4874.373, -4925.464, 3.166)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function tpIslandMain()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(4993.385, -5719.725, 19.880)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function tpIslandHarbour()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(4992.504, -5174.667, 2.503)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end

function tpIslandHarbour2()
	local vehicle
	local player = player.get_player_ped(player.player_id())
	local position = v3(5071.473, -4629.821, 2.374)

	if ped.is_ped_in_any_vehicle(player) then
		vehicle = ped.get_vehicle_ped_is_using(player)
		entity.set_entity_coords_no_offset(vehicle, position)
	else
		entity.set_entity_coords_no_offset(player, position)
	end
	return HANDLER_POP
end


function main()

	top = menu.add_feature("iplLoader", "parent", 0)
	menu.add_feature("Teleport back inside map", "action", top.id, teleportHome)
	--menu.add_feature("UnLoad All", "action", top.id, unLoadAll)
	cargoship = menu.add_feature("Cargo Ship", "parent", top.id)
	menu.add_feature("Default", "action", cargoship.id, defaultCargoship)
	menu.add_feature("Sunken", "action", cargoship.id, sunkenCargoship)
	menu.add_feature("Teleport", "action", cargoship.id, tpCargoship)
	morgue = menu.add_feature("Morgue", "parent", top.id)
	menu.add_feature("Load", "action", morgue.id, loadMorgue)
	menu.add_feature("Teleport", "action", morgue.id, tpMorgue)
	menu.add_feature("UnLoad", "action", morgue.id, unLoadMorgue)
	casino = menu.add_feature("Casino", "parent", top.id)
	menu.add_feature("Load Main Casino", "action", casino.id, LoadCasino)
	menu.add_feature("Teleport inside Casino", "action", casino.id, tpCasino)
	casinoPenthouse = menu.add_feature("Penthouse", "parent", casino.id)
	menu.add_feature("Load", "action", casinoPenthouse.id, LoadPenthouse)
	menu.add_feature("Unload", "action", casinoPenthouse.id, unLoadPenthouse)
	menu.add_feature("Teleport", "action", casinoPenthouse.id, tpPenthouse)
	casinoGarage = menu.add_feature("Garage", "parent", casino.id)
	menu.add_feature("Load", "action", casinoGarage.id, LoadCasinoGarage)
	menu.add_feature("Unload", "action", casinoGarage.id, unLoadCasinoGarage)
	menu.add_feature("Teleport", "action", casinoGarage.id, tpCasinoGarage)
	casinoCarPark = menu.add_feature("CarPark", "parent", casino.id)
	menu.add_feature("Load", "action", casinoCarPark.id, LoadCasinoCarPark)
	menu.add_feature("Unload", "action", casinoCarPark.id, unLoadCasinoCarPark)
	menu.add_feature("Teleport", "action", casinoCarPark.id, tpCasinoCarPark)
	stilt = menu.add_feature("Stilt House","parent", top.id)
	menu.add_feature("Rebuild","action", stilt.id, rebuildStilt)
	menu.add_feature("Broken","action", stilt.id, brokenStilt)
	menu.add_feature("Teleport","action", stilt.id, tpStilt)
	stadium = menu.add_feature("Stadium","parent", top.id)
	menu.add_feature("Load","action", stadium.id, loadStadium)
	menu.add_feature("Teleport","action", stadium.id, tpStadium)
	menu.add_feature("UnLoad","action", stadium.id, unLoadStadium)
	renda = menu.add_feature("Max Renda Shop","parent", top.id)
	menu.add_feature("Load","action", renda.id, loadRenda)
	menu.add_feature("Teleport","action", renda.id, tpRenda)
	menu.add_feature("UnLoad","action", renda.id, unLoadRenda)
	jewel = menu.add_feature("Jewel Store","parent", top.id)
	menu.add_feature("Load","action", jewel.id, loadJewel)
	menu.add_feature("Teleport","action", jewel.id, tpJewel)
	menu.add_feature("UnLoad","action", jewel.id, unLoadJewel)
	fib = menu.add_feature("FIB Lobby","parent", top.id)
	menu.add_feature("Load","action", fib.id, loadFIB)
	menu.add_feature("Teleport","action", fib.id, tpFIB)
	menu.add_feature("UnLoad","action", fib.id, unLoadFIB)
	trailer = menu.add_feature("Trevors Trailer","parent", top.id)
	menu.add_feature("Clean","action", trailer.id, cleanTrailer)
	menu.add_feature("Dirty","action", trailer.id, dirtyTrailer)
	menu.add_feature("Teleport","action", trailer.id, tpTrailer)
	yacht = menu.add_feature("Dignity Yacht","parent", top.id)
	menu.add_feature("Heist Yacht (MP Only)","action", yacht.id,heistYacht)
	menu.add_feature("Party Yacht","action", yacht.id, partyYacht)
	menu.add_feature("Teleport","action", yacht.id, tpYacht)
	menu.add_feature("UnLoad","action", yacht.id, unLoadYacht)
	train = menu.add_feature("Train Bridge Crash","parent", top.id)
	menu.add_feature("Load","action", train.id, loadTrain)
	menu.add_feature("Teleport","action", train.id, tpTrain)
	menu.add_feature("UnLoad","action", train.id, unLoadTrain)
	farm = menu.add_feature("ONeils Farm","parent", top.id)
	menu.add_feature("On Fire","action", farm.id, burningFarm)
	menu.add_feature("Burned","action", farm.id, burnedFarm)
	menu.add_feature("Normal","action", farm.id, normalFarm)
	menu.add_feature("Teleport","action", farm.id, tpFarm)
	chicken = menu.add_feature("Cluckin Bell Factory","parent", top.id)
	menu.add_feature("Load","action", chicken.id, loadChicken)
	menu.add_feature("Teleport", "action", chicken.id, tpChicken)
	menu.add_feature("UnLoad", "action", chicken.id, unLoadChicken)
	cargoplane = menu.add_feature("Underwater Cargo Plane","parent", top.id)
	menu.add_feature("Load","action", cargoplane.id, loadCargoPlane)
	menu.add_feature("Teleport", "action", cargoplane.id, tpCargoPlane)
	menu.add_feature("UnLoad", "action", cargoplane.id, unLoadCargoPlane)
	yankton = menu.add_feature("North Yankton", "parent", top.id)
	menu.add_feature("Load", "action", yankton.id, loadYankton)
	menu.add_feature("Teleport", "action", yankton.id, tpYankton)
	menu.add_feature("UnLoad", "action", yankton.id, unLoadYankton)
	ufo = menu.add_feature("Chilliad UFO","parent", top.id)
	menu.add_feature("Load","action", ufo.id, loadUFO)
	menu.add_feature("Teleport", "action", ufo.id, tpUFO)
	menu.add_feature("UnLoad", "action", ufo.id, unLoadUFO)
	red = menu.add_feature("Red Carpet","parent", top.id)
	menu.add_feature("Load","action", red.id, loadRed)
	menu.add_feature("Teleport", "action", red.id, tpRed)
	menu.add_feature("UnLoad", "action", red.id, unLoadRed)
	face = menu.add_feature("LifeInvader","parent", top.id)
	menu.add_feature("Load","action", face.id, loadFace)
	menu.add_feature("Teleport", "action", face.id, tpFace)
	menu.add_feature("UnLoad", "action", face.id, unLoadFace)
	island = menu.add_feature("Cayo Island","parent", top.id)
	menu.add_feature("Load (MP Only)","action", island.id, loadIsland)
	menu.add_feature("UnLoad", "action", island.id, unLoadIsland)
	menu.add_feature("Teleport to Airport", "action", island.id, tpIslandAirport)
	menu.add_feature("Teleport to Party Beach", "action", island.id, tpIslandParty)
	menu.add_feature("Teleport to Main Complex", "action", island.id, tpIslandMain)
	menu.add_feature("Teleport to Harbour", "action", island.id, tpIslandHarbour)
	menu.add_feature("Teleport to Harbour2", "action", island.id, tpIslandHarbour2)


end

main()