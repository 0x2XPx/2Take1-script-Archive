local utilities = {}

function utilities.is_player_rockstar_admin_scid(pid)
	if player.get_player_scid(pid) == 67241866 or player.get_player_scid(pid) == 24037237 or player.get_player_scid(pid) == 77817603 or player.get_player_scid(pid) == 77817603 or player.get_player_scid(pid) == 89288299 or player.get_player_scid(pid) == 88439202 or player.get_player_scid(pid) == 179848415 or player.get_player_scid(pid) == 184360405 or player.get_player_scid(pid) == 184359255 or player.get_player_scid(pid) == 182860908 or player.get_player_scid(pid) == 117639172 or player.get_player_scid(pid) == 142582982 or player.get_player_scid(pid) == 115642993 or player.get_player_scid(pid) == 100641297 or player.get_player_scid(pid) == 116815567 or player.get_player_scid(pid) == 88435319 or player.get_player_scid(pid) == 64499496 or player.get_player_scid(pid) == 174623946 or player.get_player_scid(pid) == 174626867 or player.get_player_scid(pid) == 151972200 or player.get_player_scid(pid) == 115643538 or player.get_player_scid(pid) == 144372813 or player.get_player_scid(pid) == 88047835 or player.get_player_scid(pid) == 115670847 or player.get_player_scid(pid) == 173426004 or player.get_player_scid(pid) == 170727774 or player.get_player_scid(pid) == 93759254 or player.get_player_scid(pid) == 174247774 or player.get_player_scid(pid) == 151975489 or player.get_player_scid(pid) == 146999560 or player.get_player_scid(pid) == 179930265 or player.get_player_scid(pid) == 88435236 or player.get_player_scid(pid) == 179936743 or player.get_player_scid(pid) == 179848203 or player.get_player_scid(pid) == 151158634 or player.get_player_scid(pid) == 174623904 or player.get_player_scid(pid) == 179936852 or player.get_player_scid(pid) == 117639190 or player.get_player_scid(pid) == 93759401 or player.get_player_scid(pid) == 103814653 or player.get_player_scid(pid) == 201693153 or player.get_player_scid(pid) == 193972138 or player.get_player_scid(pid) == 192796203 or player.get_player_scid(pid) == 121970978 or player.get_player_scid(pid) == 174623951 or player.get_player_scid(pid) == 174624061 or player.get_player_scid(pid) == 10552062 or player.get_player_scid(pid) == 174625194 or player.get_player_scid(pid) == 174625307 or player.get_player_scid(pid) == 174625407 or player.get_player_scid(pid) == 174625552 or player.get_player_scid(pid) == 174625647 or player.get_player_scid(pid) == 204071275 or player.get_player_scid(pid) == 138273823 or player.get_player_scid(pid) == 138302559 or player.get_player_scid(pid) == 139813495 or player.get_player_scid(pid) == 88435916 or player.get_player_scid(pid) == 174875493 or player.get_player_scid(pid) == 171094021 or player.get_player_scid(pid) == 173213117 or player.get_player_scid(pid) == 171093866 or player.get_player_scid(pid) == 88435362 or player.get_player_scid(pid) == 137601710 or player.get_player_scid(pid) == 103054099 or player.get_player_scid(pid) == 67241866 or player.get_player_scid(pid) == 104041189 or player.get_player_scid(pid) == 99453882 or player.get_player_scid(pid) == 174754789 or player.get_player_scid(pid) == 104432921 or player.get_player_scid(pid) == 147604980 or player.get_player_scid(pid) == 130291558 or player.get_player_scid(pid) == 141884823 or player.get_player_scid(pid) == 131037988 or player.get_player_scid(pid) == 153219155 or player.get_player_scid(pid) == 155527062 or player.get_player_scid(pid) == 114982881 or player.get_player_scid(pid) == 119266383 or player.get_player_scid(pid) == 119958356 or player.get_player_scid(pid) == 216820 or player.get_player_scid(pid) == 121397532 or player.get_player_scid(pid) == 121698158 or player.get_player_scid(pid) == 18965281 or player.get_player_scid(pid) == 56778561 or player.get_player_scid(pid) == 63457 or player.get_player_scid(pid) == 121943600 or player.get_player_scid(pid) == 123017343 or player.get_player_scid(pid) == 123849404 or player.get_player_scid(pid) == 127448079 or player.get_player_scid(pid) == 129159629 or player.get_player_scid(pid) == 127403483 or player.get_player_scid(pid) == 174194059 or player.get_player_scid(pid) == 131973478 or player.get_player_scid(pid) == 64234321 or player.get_player_scid(pid) == 64624133 or player.get_player_scid(pid) == 62409944 or player.get_player_scid(pid) == 64074298 or player.get_player_scid(pid) == 133709045 or player.get_player_scid(pid) == 134412628 or player.get_player_scid(pid) == 137579070 or player.get_player_scid(pid) == 137714280 or player.get_player_scid(pid) == 137851207 or player.get_player_scid(pid) == 130291511 or player.get_player_scid(pid) == 138075198 or player.get_player_scid(pid) == 89705672 or player.get_player_scid(pid) == 137663665 or player.get_player_scid(pid) == 9284553 or player.get_player_scid(pid) == 89797943 or player.get_player_scid(pid) == 147111499 or player.get_player_scid(pid) == 6597634 or player.get_player_scid(pid) == 23659342 or player.get_player_scid(pid) == 23659354 or player.get_player_scid(pid) == 103318524 or player.get_player_scid(pid) == 191415974 or player.get_player_scid(pid) == 132521200 or player.get_player_scid(pid) == 107713114 or player.get_player_scid(pid) == 107713060 or player.get_player_scid(pid) == 23659353 or player.get_player_scid(pid) == 57233573 or player.get_player_scid(pid) == 111439945 or player.get_player_scid(pid) == 81691532 or player.get_player_scid(pid) == 77205006 or player.get_player_scid(pid) == 25695975 or player.get_player_scid(pid) == 24646485 or player.get_player_scid(pid) == 49770174 or player.get_player_scid(pid) == 28776717 or player.get_player_scid(pid) == 146452200 or player.get_player_scid(pid) == 54462116 or player.get_player_scid(pid) == 53309582 or player.get_player_scid(pid) == 85593421 or player.get_player_scid(pid) == 21088063 or player.get_player_scid(pid) == 50850475 or player.get_player_scid(pid) == 31586721 or player.get_player_scid(pid) == 56583239 or player.get_player_scid(pid) == 41352312 or player.get_player_scid(pid) == 56176623 or player.get_player_scid(pid) == 20158753 or player.get_player_scid(pid) == 20158751 or player.get_player_scid(pid) == 23659351 or player.get_player_scid(pid) == 91031119 or player.get_player_scid(pid) == 91003708 or player.get_player_scid(pid) == 16396170 or player.get_player_scid(pid) == 16396157 or player.get_player_scid(pid) == 16396148 or player.get_player_scid(pid) == 16396141 or player.get_player_scid(pid) == 16396133 or player.get_player_scid(pid) == 16396126 or player.get_player_scid(pid) == 16396118 or player.get_player_scid(pid) == 16396107 or player.get_player_scid(pid) == 16396096 or player.get_player_scid(pid) == 16396091 or player.get_player_scid(pid) == 16396080 or player.get_player_scid(pid) == 16395850 or player.get_player_scid(pid) == 16395840 or player.get_player_scid(pid) == 16395850 or player.get_player_scid(pid) == 16395782 or player.get_player_scid(pid) == 16395773 or player.get_player_scid(pid) == 22577458 or player.get_player_scid(pid) == 22577440 or player.get_player_scid(pid) == 22577121 or player.get_player_scid(pid) == 16395782 or player.get_player_scid(pid) == 20158757 then
		return true
	end
end

function utilities.is_player_rockstar_admin_name(pid)
	if player.get_player_name(pid) == "Spacer-galore" or player.get_player_name(pid) == "Fortune_Cukie" or player.get_player_name(pid) == "Laurie_Williams" or player.get_player_name(pid) == "RollD20" or player.get_player_name(pid) == "SecretWizzle54" or player.get_player_name(pid) == "Wawaweewa_I_Like" or player.get_player_name(pid) == "BackBoyoDrill" or player.get_player_name(pid) == "NoAuthorityHere" or player.get_player_name(pid) == "ScentedString" or player.get_player_name(pid) == "CapnZebraZorse" or player.get_player_name(pid) == "godlyGoodestBoi" or player.get_player_name(pid) == "whiskylifter" or player.get_player_name(pid) == "pigeon_nominate" or player.get_player_name(pid) == "SlightlyEvilHoss" or player.get_player_name(pid) == "ChangryMonkey" or player.get_player_name(pid) == "StompoGrande" or player.get_player_name(pid) == "x_Shannandoo_x" or player.get_player_name(pid) == "Long-boi-load" or player.get_player_name(pid) == "NootN0ot" or player.get_player_name(pid) == "applecloning" or player.get_player_name(pid) == "BeoMonstarh" or player.get_player_name(pid) == "BlobbyFett22" or player.get_player_name(pid) == "ExoSnowBoarder" or player.get_player_name(pid) == "ExtremeThanks15" or player.get_player_name(pid) == "BailMail99" or player.get_player_name(pid) == "ForrestTrump69" or player.get_player_name(pid) == "KingOfGolf" or player.get_player_name(pid) == "KrustyShackles" or player.get_player_name(pid) == "PassiveSalon" or player.get_player_name(pid) == "PearBiscuits34" or player.get_player_name(pid) == "SlowMoKing" or player.get_player_name(pid) == "Smooth_Landing" or player.get_player_name(pid) == "SuperTrevor123" or player.get_player_name(pid) == "Tamehippo" or player.get_player_name(pid) == "uwu-bend" or player.get_player_name(pid) == "VickDMF" or player.get_player_name(pid) == "AlpacaBarista" or player.get_player_name(pid) == "The_Real_Harambe" or player.get_player_name(pid) == "Flares4Lyfe" or player.get_player_name(pid) == "FluteOfMilton" or player.get_player_name(pid) == "PipPipJongles" or player.get_player_name(pid) == "YUyu-lampon" or player.get_player_name(pid) == "DeadOnAir" or player.get_player_name(pid) == "Poppernopple" or player.get_player_name(pid) == "KrunchyCh1cken" or player.get_player_name(pid) == "BlessedChu" or player.get_player_name(pid) == "Surgeio" or player.get_player_name(pid) == "WindmillDuncan" or player.get_player_name(pid) == "Paulverines" or player.get_player_name(pid) == "ZombieTom66" or player.get_player_name(pid) == "st1nky_p1nky" or player.get_player_name(pid) == "OilyLordAinsley" or player.get_player_name(pid) == "FruitPuncher15" or player.get_player_name(pid) == "PisswasserMax" or player.get_player_name(pid) == "BanSparklinWater" or player.get_player_name(pid) == "BrucieJuiceyIV" or player.get_player_name(pid) == "RapidRaichu" or player.get_player_name(pid) == "kingmario11" or player.get_player_name(pid) == "DigitalFox9" or player.get_player_name(pid) == "FoxesAreCool69" or player.get_player_name(pid) == "SweetPlumbus" or player.get_player_name(pid) == "IM-_-Wassup" or player.get_player_name(pid) == "WickedFalcon4054" or player.get_player_name(pid) == "aquabull" or player.get_player_name(pid) == "Ghostofwar1" or player.get_player_name(pid) == "DAWNBILLA" or player.get_player_name(pid) == "Aur3lian" or player.get_player_name(pid) == "JulianApost4te" or player.get_player_name(pid) == "DarkStar7171" or player.get_player_name(pid) == "xCuteBunny" or player.get_player_name(pid) == "random_123" or player.get_player_name(pid) == "random123" or player.get_player_name(pid) == "flyingcobra16" or player.get_player_name(pid) == "CriticalRegret" or player.get_player_name(pid) == "ScentedPotter" or player.get_player_name(pid) == "Huginn5" or player.get_player_name(pid) == "Sonknuck-" or player.get_player_name(pid) == "HammerDaddy69" or player.get_player_name(pid) == "johnet123" or player.get_player_name(pid) == "bipolarcarp" or player.get_player_name(pid) == "jakw0lf" or player.get_player_name(pid) == "Kakorot02" or player.get_player_name(pid) == "CrazyCatPilots" or player.get_player_name(pid) == "G_ashman" or player.get_player_name(pid) == "Rossthetic" or player.get_player_name(pid) == "StrongBelwas1" or player.get_player_name(pid) == "vulconn" or player.get_player_name(pid) == "TonyMSD1" or player.get_player_name(pid) == "AMoreno14" or player.get_player_name(pid) == "PayneInUrAbs" or player.get_player_name(pid) == "shibuz_gamer123" or player.get_player_name(pid) == "M1thras" or player.get_player_name(pid) == "Th3_Morr1gan" or player.get_player_name(pid) == "Z3ro_Chill" or player.get_player_name(pid) == "Titan261" or player.get_player_name(pid) == "Coffee_Collie" or player.get_player_name(pid) == "YellingRat" or player.get_player_name(pid) == "BananaGod951" or player.get_player_name(pid) == "s0cc3r33" or player.get_player_name(pid) == "RDR_Dev" or player.get_player_name(pid) == "FecundWolf" or player.get_player_name(pid) == "trajan5" or player.get_player_name(pid) == "thewho146" or player.get_player_name(pid) == "Bangers_RSG" or player.get_player_name(pid) == "Bash_RSG" or player.get_player_name(pid) == "Bubblez_RSG" or player.get_player_name(pid) == "ramendingo" or player.get_player_name(pid) == "ChefRSG" or player.get_player_name(pid) == "Chunk_RSG" or player.get_player_name(pid) == "HotTub_RSG" or player.get_player_name(pid) == "JPEGMAFIA_RSG" or player.get_player_name(pid) == "Klang_RSG" or player.get_player_name(pid) == "Lean1_RSG" or player.get_player_name(pid) == "Ton_RSG" or player.get_player_name(pid) == "RSGWolfman" or player.get_player_name(pid) == "TheUntamedVoid" or player.get_player_name(pid) == "TylerTGTAB" or player.get_player_name(pid) == "Wilted_spinach" or player.get_player_name(pid) == "DannSw" or player.get_player_name(pid) == "RSGINTJoe" or player.get_player_name(pid) == "RSGGuestV" or player.get_player_name(pid) == "RSGGuest50" or player.get_player_name(pid) == "RSGGuest40" or player.get_player_name(pid) == "Logic_rsg" or player.get_player_name(pid) == "RSGGuest12" or player.get_player_name(pid) == "RSGGuest7" or player.get_player_name(pid) == "ScottM_RSG" or player.get_player_name(pid) == "Rockin5" or player.get_player_name(pid) == "MonkeyViking" or player.get_player_name(pid) == "Anghard07" or player.get_player_name(pid) == "playrockstar6" or player.get_player_name(pid) == "PlayRockstar5" or player.get_player_name(pid) == "PlayRockstar1" or player.get_player_name(pid) == "Player8_RSG" or player.get_player_name(pid) == "Player7_RSG" or player.get_player_name(pid) == "MaxPayneDev16" or player.get_player_name(pid) == "MaxPayneDev15" or player.get_player_name(pid) == "MaxPayneDev14" or player.get_player_name(pid) == "MaxPayneDev13" or player.get_player_name(pid) == "MaxPayneDev12" or player.get_player_name(pid) == "MaxPayneDev11" or player.get_player_name(pid) == "MaxPayneDev10" or player.get_player_name(pid) == "MaxPayneDev9" or player.get_player_name(pid) == "MaxPayneDev8" or player.get_player_name(pid) == "MaxPayneDev7" or player.get_player_name(pid) == "MaxPayneDev6" or player.get_player_name(pid) == "MaxPayneDev5" or player.get_player_name(pid) == "MaxPayneDev4" or player.get_player_name(pid) == "MaxPayneDev3" or player.get_player_name(pid) == "MaxPayneDev2" or player.get_player_name(pid) == "MaxPayneDev1" or player.get_player_name(pid) == "MaxPayne3Dev12" or player.get_player_name(pid) == "MaxPayne3Dev11" or player.get_player_name(pid) == "MaxPayne3Dev9" or player.get_player_name(pid) == "GTAdev4" or player.get_player_name(pid) == "GTAdev3" then
		return true
	end
end

function utilities.is_player_rockstar_admin_ip(pid)
	if utilities.dec_to_ipv4(player.get_player_ip(pid)) == "104.255.104.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "104.255.104.254" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "104.255.107.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "104.255.107.254" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.240.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.240.254" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.241.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.241.254" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.242.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.242.254" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.243.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.243.254" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.227.16" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.227.63" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.231.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.231.31" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.231.64" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.231.79" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.232.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "139.138.232.15" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.244.0" or utilities.dec_to_ipv4(player.get_player_ip(pid)) == "192.81.244.254" then
		return true
	end
end

function utilities.dec_to_ipv4(ip)
	return string.format("%i.%i.%i.%i", ip >> 24 & 255, ip >> 16 & 255, ip >> 8 & 255, ip & 255)
end

function utilities.change_player_model(hash, isWaterAnimal)
	if player.is_player_valid(player.player_id()) and not player.is_player_in_any_vehicle(player.player_id()) and (isWaterAnimal and entity.is_entity_in_water(player.get_player_ped(player.player_id())) or (not isWaterAnimal and not entity.is_entity_in_water(player.get_player_ped(player.player_id()))) or (not isWaterAnimal and entity.is_entity_in_water(player.get_player_ped(player.player_id())))) then
    	utilities.request_model(hash)
   		player.set_player_model(hash)
    	streaming.set_model_as_no_longer_needed(hash)
		system.wait(0)
		ped.set_ped_component_variation(player.get_player_ped(player.player_id()), 4, 0, 0, 2)
		entity.set_entity_visible(player.get_player_ped(player.player_id()), true)
    else
        menu.notify("[!] Model Change not possible!", "Script Additions", 3, 211)
	end
end

function utilities.is_player_typing(pid)
	if script.get_global_i(1644218 + 2 + 241 + 136 + pid) & 1 << 16 == 0 then
		return false
	else
		return true
	end
end

function utilities.is_friend_in_queue()
	local is_friend_in_queue = false
	for pid = 0, 31 do
		if player.is_player_valid(pid) and player.get_player_host_priority(pid) < player.get_player_host_priority(player.player_id()) and player.is_player_friend(pid) then
			is_friend_in_queue = true
		end
	end
	return is_friend_in_queue
end

function utilities.rotate_to_pos(Entity, Position)
    local entity_pos = entity.get_entity_coords(Entity)
    local pos = Position
    local height = 2;

    local X = pos.x - entity_pos.x
    local Y = pos.y - entity_pos.y
    local Z = (entity_pos.z - pos.z + height) * -1

    local pointAtHeadingAngle = math.atan(X, Y) * -180 / math.pi
    local pointAtAngle = math.asin(Z / pos:magnitude(entity_pos)) / (2 * math.pi) * 360
    
    entity.set_entity_rotation(Entity, v3(pointAtAngle, 0, pointAtHeadingAngle))
end

function utilities.get_surface_player_is_aiming_at(pid)
	local rot = cam.get_gameplay_cam_rot()
	rot:transformRotToDir()
	local pos = select(2, worldprobe.raycast(player.get_player_coords(pid), rot * 1000 + cam.get_gameplay_cam_pos(), -1, player.get_player_ped(pid)))
	return pos
end

function utilities.is_player_moving(pid)
	if player.is_player_valid(pid) then
		local pos = v3(utilities.round_two_dc(player.get_player_coords(pid).x), utilities.round_two_dc(player.get_player_coords(pid).y), utilities.round_two_dc(player.get_player_coords(pid).z))
		system.wait(0)
		if pos == v3(utilities.round_two_dc(player.get_player_coords(pid).x), utilities.round_two_dc(player.get_player_coords(pid).y), utilities.round_two_dc(player.get_player_coords(pid).z)) then
			return false
		else
			return true
		end
	else
		return false
	end
end

function utilities.is_player_moving_fast(pid)
	if player.is_player_valid(pid) then
		local pos = v3(utilities.round_one_dc(player.get_player_coords(pid).x), utilities.round_one_dc(player.get_player_coords(pid).y), utilities.round_one_dc(player.get_player_coords(pid).z))
		system.wait(0)
		if pos == v3(utilities.round_one_dc(player.get_player_coords(pid).x), utilities.round_one_dc(player.get_player_coords(pid).y), utilities.round_one_dc(player.get_player_coords(pid).z)) then
			return false
		else
			return true
		end
	else
		return false
	end
end

function utilities.is_model_a_fighter_plane(hash)
	if hash == 3319621991 or hash == 1565978651 or hash == 1692272545 or hash == 3013282534 or hash == 1036591958 or hash == 2908775872 or hash == 1824333165 or hash == 970385471 or hash == 2594093022 or hash == 3545667823 then
		return true
	else
		return false
	end
end

function utilities.is_model_a_slow_plane(hash)
	if hash == 2621610858 or hash == 1077420264 or hash == 2176659152 or hash == 970356638 or hash == 1043222410 or hash == 2548391185 or hash == 4262088844 or hash == 3393804037 or hash == 408970549 or hash == 970385471 or hash == 3650256867 or hash == 2531412055 then
		return true
	else
		return false
	end
end

function utilities.get_host_queue_count()
	host_queue_count = 0
	for pid = 0, 31 do
		if player.is_player_valid(pid) and player.get_player_host_priority(pid) < player.get_player_host_priority(player.player_id()) then
			host_queue_count = host_queue_count + 1
		end
	end
	return host_queue_count
end

function utilities.write(file, text)
    if file and text then
        io.output(file)
        io.write(text)
        io.close(file)
    end
end

function utilities.is_player_in_interior(pid)
	if player.is_player_valid(pid) then
		if interior.get_interior_from_entity(player.get_player_ped(pid)) ~= 0 and player.get_player_coords(pid).z > 0 and player.get_player_coords(pid).z < 200 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function utilities.get_closest_player_to_coords(coords)
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

function utilities.get_closest_player_to_coords_in_range(coords, range)
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

function utilities.get_distance_between(pos1, pos2)
	if math.type(pos1) == "integer" then
		pos1 = entity.get_entity_coords(pos1)
	end
	if math.type(pos2) == "integer" then 
		pos2 = entity.get_entity_coords(pos2)
	end
	return pos1:magnitude(pos2)
end

function utilities.send_to_brazil(pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(-621279188, pid, {player.player_id(), 1})
		system.wait(1)
		script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 1})
		system.wait(1)
		script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 1})
		system.wait(1)
		for i = 1, 27 do
			script.trigger_script_event(962740265, pid, {player.player_id(), i})
			system.wait(1)
		end
		script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 4, 0})
		system.wait(1)
		for i = 1, 22 do
			script.trigger_script_event(-446275082, pid, {player.player_id(), 0, 1, i})
			system.wait(1)
		end
		script.trigger_script_event(603406648, pid, {player.player_id(), pid, pid, pid, 86})
		system.wait(1)
		for i = 1, 114 do
			script.trigger_script_event(603406648, pid, {player.player_id(), pid, pid, pid, i})
			system.wait(1)
		end
		for i = 1, 22 do
			script.trigger_script_event(-1525161016, pid, {player.player_id(), 0, 1, i})
			system.wait(1)
			script.trigger_script_event(-614457627, pid, {player.player_id(), 0, 1, i})
			system.wait(1)
		end
		for i = 0, 7 do
			script.trigger_script_event(2020588206, pid, {player.player_id(), i})
			system.wait(1)
		end
		script.trigger_script_event(-621279188, pid, {player.player_id(), 1})
		system.wait(1)
		script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 1})
		system.wait(1)
		script.trigger_script_event(1463943751, pid, {player.player_id(), pid, pid, 3, 1})
		system.wait(1)
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end

function utilities.clear_entities(table_of_entities)
	for i = 1, 2 do
		local count = 0
		local removed_entities = 0
		for i, Entity in pairs(table_of_entities) do
			if not ped.is_ped_a_player(Entity) then
				network.request_control_of_entity(Entity)
				count = count + 1
				if network.has_control_of_entity(Entity) then
					ui.remove_blip(ui.get_blip_from_entity(Entity))
					entity.set_entity_as_mission_entity(Entity, false, true)
					entity.delete_entity(Entity)
					if not entity.is_an_entity(Entity) then
						removed_entities = removed_entities + 1
						table_of_entities[i] = nil
					end
				end
				if count % 16 == 15 then
					system.yield(0)
				end
			end
		end
		if i == 1 and removed_entities ~= count then
			system.yield(0)
		end
	end
end

function utilities.get_parent_of_attachments(Entity)
	if entity.is_entity_attached(Entity) then
		return utilities.get_parent_of_attachments(entity.get_entity_attached_to(Entity))
	else
		return Entity
	end
end

function utilities.get_all_attached_entities(Entity)
	local entities = {}
	local all_entities = {}
	local peds = ped.get_all_peds()
	local vehicles = vehicle.get_all_vehicles()
	local objects = object.get_all_objects()
	local pickups = object.get_all_pickups()
	for i = 1, #peds do
		if not ped.is_ped_a_player(peds[i]) then
			table.insert(all_entities, peds[i])
		end
	end
	for i = 1, #vehicles do
		table.insert(all_entities, vehicles[i])
	end
	for i = 1, #objects do
		table.insert(all_entities, objects[i])
	end
	for i = 1, #pickups do
		table.insert(all_entities, pickups[i])
	end
	for i = 1, #all_entities do
		if entity.get_entity_attached_to(all_entities[i]) == Entity and (not entity.is_entity_a_ped(all_entities[i]) or not ped.is_ped_a_player(all_entities[i])) then
			entities[#entities + 1] = all_entities[i]
			local attached_entities = utilities.get_all_attached_entities(all_entities[i])
			table.move(attached_entities, 1, #attached_entities, #entities + 1, entities)
		end
	end
	return entities
end

function utilities.hard_remove_entity(Entity)
	if entity.is_an_entity(Entity) then
		Entity = utilities.get_parent_of_attachments(Entity)
		if entity.is_an_entity(Entity) and (not entity.is_entity_a_ped(Entity) or not ped.is_ped_a_player(Entity)) then
			utilities.clear_entities(utilities.get_all_attached_entities(Entity))
			utilities.clear_entities({Entity})
		end
	end
end

function utilities.request_model(model_hash)
	local is_hash_already_loaded = not streaming.has_model_loaded(model_hash)
	if is_hash_already_loaded then
		streaming.request_model(model_hash)
		local time = utils.time_ms() + 450
		while not streaming.has_model_loaded(model_hash) and time > utils.time_ms() do
			system.yield(0)
		end
	end
	return streaming.has_model_loaded(model_hash), is_hash_already_loaded
end

function utilities.set_entity_coords(i, p)
	network.request_control_of_entity(i)
	while not network.has_control_of_entity(i) do
		network.request_control_of_entity(i)
		system.wait(0)
	end
    entity.set_entity_velocity(i, v3())
    entity.set_entity_coords_no_offset(i, p)
end

function utilities.clear_ptfx(ptfx)
	network.request_control_of_entity(ptfx)
    entity.detach_entity(ptfx)
    entity.set_entity_as_mission_entity(ptfx, true, true)
    entity.set_entity_velocity(ptfx, v3())
    entity.set_entity_coords_no_offset(ptfx, v3(8000, 8000, -1000))
	entity.delete_entity(ptfx)
	utilities.hard_remove_entity(ptfx)
	entity.set_entity_as_no_longer_needed(ptfx)
end

function utilities.spawn_object(hash, pos, networked, dynamic)
    if not hash then
        return
    end

    utilities.request_model(hash)
    pos = pos or v3()
    networked = networked or true
    dynamic = dynamic or false

    return object.create_object(hash, pos, networked, dynamic)
end

function utilities.se_kick(pid)
	if player.is_player_valid(pid) then
		script.trigger_script_event(0x4E0350C6, pid, utilities.random_args(pid, 15))
		script.trigger_script_event(-227800145, pid, {pid, math.random(32, 23647483647), math.random(-23647, 212347), 1, 115, math.random(-2321647, 21182412647), math.random(-2147483647, 2147483647), 26249, math.random(-1257483647, 23683647), 2623, 25136})
		script.trigger_script_event(69874647, pid, {pid, math.random(32, 23647483647), math.random(-23647, 212347), 1, 115, math.random(-2321647, 21182412647), math.random(-2147483647, 2147483647), 26249, math.random(-1257483647, 23683647), 2623, 25136})
		script.trigger_script_event(0x23F74138, pid, {pid, math.random(32, 2147483647), math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		script.trigger_script_event(-0x249FE11B, pid, utilities.random_args(pid, 15))
		script.trigger_script_event(-227800145, pid, {pid, pid, math.random(-2147483647, 2147483647), 2361235669, math.random(-2147483647, 2147483647), 263261, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), 215132521, 5262462321, math.random(-2147483647, 2147483647), pid})
		script.trigger_script_event(0x23F74138, pid, {pid, math.random(32, 2147483647), math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		script.trigger_script_event(1445703181, pid, {pid, pid, math.random(-2147483647, 2147483647), 136236, math.random(-5262, 216247), math.random(-2147483647, 2147483647), math.random(-2623647, 2143247), 1587193, math.random(-214626647, 21475247), math.random(-2123647, 2363647), 651264, math.random(-13683647, 2323647), 1951923, math.random(-2147483647, 2147483647), math.random(-2136247, 21627), 2359273, math.random(-214732, 21623647), pid})
		script.trigger_script_event(0x23F74138, pid, {pid, math.random(-2147483647, -1), math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
		script.trigger_script_event(-0x76B11968, pid, utilities.random_args(pid, 15))
	else
		menu.notify("[!] Invalid Player.", Meteor, 3, 211)
	end
end

function utilities.remove_player_entities(table_of_entities)
	local new = {}
	for _, Entity in pairs(table_of_entities) do
		if entity.is_an_entity(Entity) and (not entity.is_entity_a_ped(Entity) or not ped.is_ped_a_player(Entity)) then
			local status = true
			if entity.is_entity_a_vehicle(Entity) then
				for pid = 0, 31 do
					if player.get_player_vehicle(pid) == Entity then
						status = false
						break
					end
				end
			end
			if status then
				new[#new + 1] = Entity
			end
		end
	end
	return new
end

function utilities.get_table_of_entities(entity_table, max_count, max_range, remove_players, sort_to_distance, start_pos)
	local new_entity_table = {}
	local current_count = 0
	for i = 1, #entity_table do
		if current_count < max_count then
			if utilities.get_distance_between(start_pos, entity_table[i]) < max_range then
				table.insert(new_entity_table, entity_table[i])
				current_count = current_count + 1
			end
		end
	end
	if remove_players then
		utilities.remove_player_entities(new_entity_table)
	end
	if sort_to_distance then
		table.sort(new_entity_table, function(a, b)
			return (utilities.get_distance_between(a, start_pos) < utilities.get_distance_between(b, start_pos))
		end)
	end
	return new_entity_table
end

function utilities.add_blip_for_entity(Entity, Id)
    local blip = ui.add_blip_for_entity(Entity)
    ui.set_blip_sprite(blip, Id)
end

function utilities.round(num)
	local floor = math.floor(num)
	if floor >= num - 0.4999999999 then
		return floor
	else
		return math.ceil(num)
	end
end

function utilities.round_one_dc(value)
	local value = value * 10
	local value = math.floor(value)
	local value = value / 10
	return value
end

function utilities.round_two_dc(value)
	local value = value * 100
	local value = math.floor(value)
	local value = value / 100
	return value
end

function utilities.round_three_dc(value)
	local value = value * 1000
	local value = math.floor(value)
	local value = value / 1000
	return value
end

function utilities.offset_coords_forward(pos, heading, distance)
    heading = math.rad((heading - 180) * -1)
    pos.x = pos.x + (math.sin(heading) * -distance)
    pos.y = pos.y + (math.cos(heading) * -distance)
    return pos
end

function utilities.offset_coords_back(pos, heading, distance)
    heading = math.rad((heading - 360) * -1)
    pos.x = pos.x + (math.sin(heading) * -distance)
    pos.y = pos.y + (math.cos(heading) * -distance)
    return pos
end

function utilities.offset_coords_left(pos, heading, distance)
    heading = math.rad((heading - 90) * -1)
    pos.x = pos.x + (math.sin(heading) * -distance)
    pos.y = pos.y + (math.cos(heading) * -distance)
    return pos
end

function utilities.offset_coords_right(pos, heading, distance)
    heading = math.rad((heading + 90) * -1)
    pos.x = pos.x + (math.sin(heading) * -distance)
    pos.y = pos.y + (math.cos(heading) * -distance)
    return pos
end

function utilities.to_int(n)
    local s = tostring(n)
    local i, j = s:find("%.")
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end

return utilities