local utilities = require("Meteor/Lib/Utils")
local text_func = require("Meteor/Lib/Text_Func")

local player_func = {}

function player_func.is_player_rockstar_admin_scid(pid)
	if player.get_player_scid(pid) == 67241866 or player.get_player_scid(pid) == 24037237 or player.get_player_scid(pid) == 77817603 or player.get_player_scid(pid) == 77817603 or player.get_player_scid(pid) == 89288299 or player.get_player_scid(pid) == 88439202 or player.get_player_scid(pid) == 179848415 or player.get_player_scid(pid) == 184360405 or player.get_player_scid(pid) == 184359255 or player.get_player_scid(pid) == 182860908 or player.get_player_scid(pid) == 117639172 or player.get_player_scid(pid) == 142582982 or player.get_player_scid(pid) == 115642993 or player.get_player_scid(pid) == 100641297 or player.get_player_scid(pid) == 116815567 or player.get_player_scid(pid) == 88435319 or player.get_player_scid(pid) == 64499496 or player.get_player_scid(pid) == 174623946 or player.get_player_scid(pid) == 174626867 or player.get_player_scid(pid) == 151972200 or player.get_player_scid(pid) == 115643538 or player.get_player_scid(pid) == 144372813 or player.get_player_scid(pid) == 88047835 or player.get_player_scid(pid) == 115670847 or player.get_player_scid(pid) == 173426004 or player.get_player_scid(pid) == 170727774 or player.get_player_scid(pid) == 93759254 or player.get_player_scid(pid) == 174247774 or player.get_player_scid(pid) == 151975489 or player.get_player_scid(pid) == 146999560 or player.get_player_scid(pid) == 179930265 or player.get_player_scid(pid) == 88435236 or player.get_player_scid(pid) == 179936743 or player.get_player_scid(pid) == 179848203 or player.get_player_scid(pid) == 151158634 or player.get_player_scid(pid) == 174623904 or player.get_player_scid(pid) == 179936852 or player.get_player_scid(pid) == 117639190 or player.get_player_scid(pid) == 93759401 or player.get_player_scid(pid) == 103814653 or player.get_player_scid(pid) == 201693153 or player.get_player_scid(pid) == 193972138 or player.get_player_scid(pid) == 192796203 or player.get_player_scid(pid) == 121970978 or player.get_player_scid(pid) == 174623951 or player.get_player_scid(pid) == 174624061 or player.get_player_scid(pid) == 10552062 or player.get_player_scid(pid) == 174625194 or player.get_player_scid(pid) == 174625307 or player.get_player_scid(pid) == 174625407 or player.get_player_scid(pid) == 174625552 or player.get_player_scid(pid) == 174625647 or player.get_player_scid(pid) == 204071275 or player.get_player_scid(pid) == 138273823 or player.get_player_scid(pid) == 138302559 or player.get_player_scid(pid) == 139813495 or player.get_player_scid(pid) == 88435916 or player.get_player_scid(pid) == 174875493 or player.get_player_scid(pid) == 171094021 or player.get_player_scid(pid) == 173213117 or player.get_player_scid(pid) == 171093866 or player.get_player_scid(pid) == 88435362 or player.get_player_scid(pid) == 137601710 or player.get_player_scid(pid) == 103054099 or player.get_player_scid(pid) == 67241866 or player.get_player_scid(pid) == 104041189 or player.get_player_scid(pid) == 99453882 or player.get_player_scid(pid) == 174754789 or player.get_player_scid(pid) == 104432921 or player.get_player_scid(pid) == 147604980 or player.get_player_scid(pid) == 130291558 or player.get_player_scid(pid) == 141884823 or player.get_player_scid(pid) == 131037988 or player.get_player_scid(pid) == 153219155 or player.get_player_scid(pid) == 155527062 or player.get_player_scid(pid) == 114982881 or player.get_player_scid(pid) == 119266383 or player.get_player_scid(pid) == 119958356 or player.get_player_scid(pid) == 216820 or player.get_player_scid(pid) == 121397532 or player.get_player_scid(pid) == 121698158 or player.get_player_scid(pid) == 18965281 or player.get_player_scid(pid) == 56778561 or player.get_player_scid(pid) == 63457 or player.get_player_scid(pid) == 121943600 or player.get_player_scid(pid) == 123017343 or player.get_player_scid(pid) == 123849404 or player.get_player_scid(pid) == 127448079 or player.get_player_scid(pid) == 129159629 or player.get_player_scid(pid) == 127403483 or player.get_player_scid(pid) == 174194059 or player.get_player_scid(pid) == 131973478 or player.get_player_scid(pid) == 64234321 or player.get_player_scid(pid) == 64624133 or player.get_player_scid(pid) == 62409944 or player.get_player_scid(pid) == 64074298 or player.get_player_scid(pid) == 133709045 or player.get_player_scid(pid) == 134412628 or player.get_player_scid(pid) == 137579070 or player.get_player_scid(pid) == 137714280 or player.get_player_scid(pid) == 137851207 or player.get_player_scid(pid) == 130291511 or player.get_player_scid(pid) == 138075198 or player.get_player_scid(pid) == 89705672 or player.get_player_scid(pid) == 137663665 or player.get_player_scid(pid) == 9284553 or player.get_player_scid(pid) == 89797943 or player.get_player_scid(pid) == 147111499 or player.get_player_scid(pid) == 6597634 or player.get_player_scid(pid) == 23659342 or player.get_player_scid(pid) == 23659354 or player.get_player_scid(pid) == 103318524 or player.get_player_scid(pid) == 191415974 or player.get_player_scid(pid) == 132521200 or player.get_player_scid(pid) == 107713114 or player.get_player_scid(pid) == 107713060 or player.get_player_scid(pid) == 23659353 or player.get_player_scid(pid) == 57233573 or player.get_player_scid(pid) == 111439945 or player.get_player_scid(pid) == 81691532 or player.get_player_scid(pid) == 77205006 or player.get_player_scid(pid) == 25695975 or player.get_player_scid(pid) == 24646485 or player.get_player_scid(pid) == 49770174 or player.get_player_scid(pid) == 28776717 or player.get_player_scid(pid) == 146452200 or player.get_player_scid(pid) == 54462116 or player.get_player_scid(pid) == 53309582 or player.get_player_scid(pid) == 85593421 or player.get_player_scid(pid) == 21088063 or player.get_player_scid(pid) == 50850475 or player.get_player_scid(pid) == 31586721 or player.get_player_scid(pid) == 56583239 or player.get_player_scid(pid) == 41352312 or player.get_player_scid(pid) == 56176623 or player.get_player_scid(pid) == 20158753 or player.get_player_scid(pid) == 20158751 or player.get_player_scid(pid) == 23659351 or player.get_player_scid(pid) == 91031119 or player.get_player_scid(pid) == 91003708 or player.get_player_scid(pid) == 16396170 or player.get_player_scid(pid) == 16396157 or player.get_player_scid(pid) == 16396148 or player.get_player_scid(pid) == 16396141 or player.get_player_scid(pid) == 16396133 or player.get_player_scid(pid) == 16396126 or player.get_player_scid(pid) == 16396118 or player.get_player_scid(pid) == 16396107 or player.get_player_scid(pid) == 16396096 or player.get_player_scid(pid) == 16396091 or player.get_player_scid(pid) == 16396080 or player.get_player_scid(pid) == 16395850 or player.get_player_scid(pid) == 16395840 or player.get_player_scid(pid) == 16395850 or player.get_player_scid(pid) == 16395782 or player.get_player_scid(pid) == 16395773 or player.get_player_scid(pid) == 22577458 or player.get_player_scid(pid) == 22577440 or player.get_player_scid(pid) == 22577121 or player.get_player_scid(pid) == 16395782 or player.get_player_scid(pid) == 20158757 then
		return true
	end
end

function player_func.is_player_rockstar_admin_name(pid)
	if player.get_player_name(pid) == "Spacer-galore" or player.get_player_name(pid) == "Fortune_Cukie" or player.get_player_name(pid) == "Laurie_Williams" or player.get_player_name(pid) == "RollD20" or player.get_player_name(pid) == "SecretWizzle54" or player.get_player_name(pid) == "Wawaweewa_I_Like" or player.get_player_name(pid) == "BackBoyoDrill" or player.get_player_name(pid) == "NoAuthorityHere" or player.get_player_name(pid) == "ScentedString" or player.get_player_name(pid) == "CapnZebraZorse" or player.get_player_name(pid) == "godlyGoodestBoi" or player.get_player_name(pid) == "whiskylifter" or player.get_player_name(pid) == "pigeon_nominate" or player.get_player_name(pid) == "SlightlyEvilHoss" or player.get_player_name(pid) == "ChangryMonkey" or player.get_player_name(pid) == "StompoGrande" or player.get_player_name(pid) == "x_Shannandoo_x" or player.get_player_name(pid) == "Long-boi-load" or player.get_player_name(pid) == "NootN0ot" or player.get_player_name(pid) == "applecloning" or player.get_player_name(pid) == "BeoMonstarh" or player.get_player_name(pid) == "BlobbyFett22" or player.get_player_name(pid) == "ExoSnowBoarder" or player.get_player_name(pid) == "ExtremeThanks15" or player.get_player_name(pid) == "BailMail99" or player.get_player_name(pid) == "ForrestTrump69" or player.get_player_name(pid) == "KingOfGolf" or player.get_player_name(pid) == "KrustyShackles" or player.get_player_name(pid) == "PassiveSalon" or player.get_player_name(pid) == "PearBiscuits34" or player.get_player_name(pid) == "SlowMoKing" or player.get_player_name(pid) == "Smooth_Landing" or player.get_player_name(pid) == "SuperTrevor123" or player.get_player_name(pid) == "Tamehippo" or player.get_player_name(pid) == "uwu-bend" or player.get_player_name(pid) == "VickDMF" or player.get_player_name(pid) == "AlpacaBarista" or player.get_player_name(pid) == "The_Real_Harambe" or player.get_player_name(pid) == "Flares4Lyfe" or player.get_player_name(pid) == "FluteOfMilton" or player.get_player_name(pid) == "PipPipJongles" or player.get_player_name(pid) == "YUyu-lampon" or player.get_player_name(pid) == "DeadOnAir" or player.get_player_name(pid) == "Poppernopple" or player.get_player_name(pid) == "KrunchyCh1cken" or player.get_player_name(pid) == "BlessedChu" or player.get_player_name(pid) == "Surgeio" or player.get_player_name(pid) == "WindmillDuncan" or player.get_player_name(pid) == "Paulverines" or player.get_player_name(pid) == "ZombieTom66" or player.get_player_name(pid) == "st1nky_p1nky" or player.get_player_name(pid) == "OilyLordAinsley" or player.get_player_name(pid) == "FruitPuncher15" or player.get_player_name(pid) == "PisswasserMax" or player.get_player_name(pid) == "BanSparklinWater" or player.get_player_name(pid) == "BrucieJuiceyIV" or player.get_player_name(pid) == "RapidRaichu" or player.get_player_name(pid) == "kingmario11" or player.get_player_name(pid) == "DigitalFox9" or player.get_player_name(pid) == "FoxesAreCool69" or player.get_player_name(pid) == "SweetPlumbus" or player.get_player_name(pid) == "IM-_-Wassup" or player.get_player_name(pid) == "WickedFalcon4054" or player.get_player_name(pid) == "aquabull" or player.get_player_name(pid) == "Ghostofwar1" or player.get_player_name(pid) == "DAWNBILLA" or player.get_player_name(pid) == "Aur3lian" or player.get_player_name(pid) == "JulianApost4te" or player.get_player_name(pid) == "DarkStar7171" or player.get_player_name(pid) == "xCuteBunny" or player.get_player_name(pid) == "random_123" or player.get_player_name(pid) == "random123" or player.get_player_name(pid) == "flyingcobra16" or player.get_player_name(pid) == "CriticalRegret" or player.get_player_name(pid) == "ScentedPotter" or player.get_player_name(pid) == "Huginn5" or player.get_player_name(pid) == "Sonknuck-" or player.get_player_name(pid) == "HammerDaddy69" or player.get_player_name(pid) == "johnet123" or player.get_player_name(pid) == "bipolarcarp" or player.get_player_name(pid) == "jakw0lf" or player.get_player_name(pid) == "Kakorot02" or player.get_player_name(pid) == "CrazyCatPilots" or player.get_player_name(pid) == "G_ashman" or player.get_player_name(pid) == "Rossthetic" or player.get_player_name(pid) == "StrongBelwas1" or player.get_player_name(pid) == "vulconn" or player.get_player_name(pid) == "TonyMSD1" or player.get_player_name(pid) == "AMoreno14" or player.get_player_name(pid) == "PayneInUrAbs" or player.get_player_name(pid) == "shibuz_gamer123" or player.get_player_name(pid) == "M1thras" or player.get_player_name(pid) == "Th3_Morr1gan" or player.get_player_name(pid) == "Z3ro_Chill" or player.get_player_name(pid) == "Titan261" or player.get_player_name(pid) == "Coffee_Collie" or player.get_player_name(pid) == "YellingRat" or player.get_player_name(pid) == "BananaGod951" or player.get_player_name(pid) == "s0cc3r33" or player.get_player_name(pid) == "RDR_Dev" or player.get_player_name(pid) == "FecundWolf" or player.get_player_name(pid) == "trajan5" or player.get_player_name(pid) == "thewho146" or player.get_player_name(pid) == "Bangers_RSG" or player.get_player_name(pid) == "Bash_RSG" or player.get_player_name(pid) == "Bubblez_RSG" or player.get_player_name(pid) == "ramendingo" or player.get_player_name(pid) == "ChefRSG" or player.get_player_name(pid) == "Chunk_RSG" or player.get_player_name(pid) == "HotTub_RSG" or player.get_player_name(pid) == "JPEGMAFIA_RSG" or player.get_player_name(pid) == "Klang_RSG" or player.get_player_name(pid) == "Lean1_RSG" or player.get_player_name(pid) == "Ton_RSG" or player.get_player_name(pid) == "RSGWolfman" or player.get_player_name(pid) == "TheUntamedVoid" or player.get_player_name(pid) == "TylerTGTAB" or player.get_player_name(pid) == "Wilted_spinach" or player.get_player_name(pid) == "DannSw" or player.get_player_name(pid) == "RSGINTJoe" or player.get_player_name(pid) == "RSGGuestV" or player.get_player_name(pid) == "RSGGuest50" or player.get_player_name(pid) == "RSGGuest40" or player.get_player_name(pid) == "Logic_rsg" or player.get_player_name(pid) == "RSGGuest12" or player.get_player_name(pid) == "RSGGuest7" or player.get_player_name(pid) == "ScottM_RSG" or player.get_player_name(pid) == "Rockin5" or player.get_player_name(pid) == "MonkeyViking" or player.get_player_name(pid) == "Anghard07" or player.get_player_name(pid) == "playrockstar6" or player.get_player_name(pid) == "PlayRockstar5" or player.get_player_name(pid) == "PlayRockstar1" or player.get_player_name(pid) == "Player8_RSG" or player.get_player_name(pid) == "Player7_RSG" or player.get_player_name(pid) == "MaxPayneDev16" or player.get_player_name(pid) == "MaxPayneDev15" or player.get_player_name(pid) == "MaxPayneDev14" or player.get_player_name(pid) == "MaxPayneDev13" or player.get_player_name(pid) == "MaxPayneDev12" or player.get_player_name(pid) == "MaxPayneDev11" or player.get_player_name(pid) == "MaxPayneDev10" or player.get_player_name(pid) == "MaxPayneDev9" or player.get_player_name(pid) == "MaxPayneDev8" or player.get_player_name(pid) == "MaxPayneDev7" or player.get_player_name(pid) == "MaxPayneDev6" or player.get_player_name(pid) == "MaxPayneDev5" or player.get_player_name(pid) == "MaxPayneDev4" or player.get_player_name(pid) == "MaxPayneDev3" or player.get_player_name(pid) == "MaxPayneDev2" or player.get_player_name(pid) == "MaxPayneDev1" or player.get_player_name(pid) == "MaxPayne3Dev12" or player.get_player_name(pid) == "MaxPayne3Dev11" or player.get_player_name(pid) == "MaxPayne3Dev9" or player.get_player_name(pid) == "GTAdev4" or player.get_player_name(pid) == "GTAdev3" then
		return true
	end
end

function player_func.is_player_rockstar_admin_ip(pid)
	if utilities.dec_to_ipv4(player.get_player_ip(pid)) == "104.255.104.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "104.255.104.254" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "104.255.107.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "104.255.107.254" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.240.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.240.254" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.241.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.241.254" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.242.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.242.254" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.243.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.243.254" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.227.16" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.227.63" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.231.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.231.31" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.231.64" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.231.79" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.232.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.232.15" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.244.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.244.254" then
		return true
	end
end

function player_func.is_player_typing(pid)
	if script.get_global_i(1644218 + 2 + 241 + 136 + pid) & 1 << 16 == 0 then
		return false
	else
		return true
	end
end

function player_func.is_player_moving_slow(pid)
	if player.is_player_valid(pid) then
		local pos = player.get_player_coords(pid)
		system.wait(0)
		if pos.x ~= player.get_player_coords(pid).x or pos.y ~= player.get_player_coords(pid).y then
			return true
		else
			return false
		end
	else
		return false
	end
end

function player_func.is_player_moving(pid)
	if player.is_player_valid(pid) then
		local pos = v3(text_func.round_two_dc(player.get_player_coords(pid).x), text_func.round_two_dc(player.get_player_coords(pid).y), text_func.round_two_dc(player.get_player_coords(pid).z))
		system.wait(0)
		if pos.x ~= text_func.round_two_dc(player.get_player_coords(pid).x) or pos.y ~= text_func.round_two_dc(player.get_player_coords(pid).y) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function player_func.is_player_moving_fast(pid)
	if player.is_player_valid(pid) then
		local pos = v3(text_func.round_one_dc(player.get_player_coords(pid).x), text_func.round_one_dc(player.get_player_coords(pid).y), text_func.round_one_dc(player.get_player_coords(pid).z))
		system.wait(0)
		if pos.x ~= text_func.round_one_dc(player.get_player_coords(pid).x) or pos.y ~= text_func.round_one_dc(player.get_player_coords(pid).y) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function player_func.get_surface_player_is_aiming_at(pid)
	local rot = cam.get_gameplay_cam_rot()
	rot:transformRotToDir()
	local pos = select(2, worldprobe.raycast(player.get_player_coords(pid), rot * 1000 + cam.get_gameplay_cam_pos(), -1, player.get_player_ped(pid)))
	return pos
end

function player_func.is_friend_in_host_queue()
	local is_friend_in_queue = false
	for pid = 0, 31 do
		if player.is_player_valid(pid) and player.get_player_host_priority(pid) < player.get_player_host_priority(player.player_id()) and player.is_player_friend(pid) then
			is_friend_in_queue = true
		end
	end
	return is_friend_in_queue
end

function player_func.get_id_from_name(string_name)
	if string_name == "" or math.type(tonumber(string_name)) == "integer" then
		return nil
	else
		local is_checking_names = true
		local first_match = nil
		for pid = 0, 31 do
			if player.is_player_valid(pid) then
				if is_checking_names then
					if string.find(player.get_player_name(pid):lower(), string_name:lower()) then
						first_match = pid
						is_checking_names = false
					end
				end
			end
		end
		return first_match
	end
end

function player_func.get_host_queue_count()
	host_queue_count = 0
	for pid = 0, 31 do
		if player.is_player_valid(pid) and player.get_player_host_priority(pid) < player.get_player_host_priority(player.player_id()) then
			host_queue_count = host_queue_count + 1
		end
	end
	return host_queue_count
end

function player_func.is_player_in_interior(pid)
	if player.is_player_valid(pid) then
		if interior.get_interior_from_entity(player.get_player_ped(pid)) ~= 0 or player.get_player_coords(pid).z < 0 or player.get_player_coords(pid).z > 200 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function player_func.change_player_model(hash, isWaterAnimal)
	if player.is_player_valid(player.player_id()) and not player.is_player_in_any_vehicle(player.player_id()) and (isWaterAnimal and entity.is_entity_in_water(player.get_player_ped(player.player_id())) or (not isWaterAnimal and not entity.is_entity_in_water(player.get_player_ped(player.player_id()))) or (not isWaterAnimal and entity.is_entity_in_water(player.get_player_ped(player.player_id())))) then
    	utilities.request_model(hash)
   		player.set_player_model(hash)
    	streaming.set_model_as_no_longer_needed(hash)
		system.wait(0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 4, 0, 0, 2)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
    else
        menu.notify("Model Change not possible!", Meteor, 3, 211)
	end
end

function player_func.get_closest_player_to_coords(coords)
	local player_table = {}
	for pid = 0, 31 do
		if player.player_id() ~= pid and player.is_player_valid(pid) then
			table.insert(player_table, player.get_player_ped(pid))
		end
	end
	table.sort(player_table, function(a, b)
		return (utilities.get_distance_between(a, coords) < utilities.get_distance_between(b, coords))
	end)
	if #player_table == 0 then
		return player.player_id()
	else
		return player.get_player_from_ped(player_table[1])
	end
end

function player_func.get_closest_player_to_coords_in_range(coords, range)
	local player_table = {}
	for pid = 0, 31 do
		if player.player_id() ~= pid and player.is_player_valid(pid) and utilities.get_distance_between(coords, player.get_player_coords(pid)) < range then
			table.insert(player_table, player.get_player_ped(pid))
		end
	end
	table.sort(player_table, function(a, b)
		return (utilities.get_distance_between(a, coords) < utilities.get_distance_between(b, coords))
	end)
	if #player_table == 0 then
		return player.player_id()
	else
		return player.get_player_from_ped(player_table[1])
	end
end

return player_func