local c = {} --  base short api
local a = {} --  feature table


 --  base short api
c.df = menu.add_feature
c.wait = system.wait
c.me = player.player_id
c.pdf = menu.add_player_feature




a.opption = c.pdf("player","parent",0).id

---function
local function createped(type, hash, pos, dir)
		streaming.request_model(hash)
	    while not streaming.has_model_loaded(hash) do
		system.wait(10)
	    end
		local ped = ped.create_ped(type, hash, pos, dir, true, false)
			streaming.set_model_as_no_longer_needed(hash)
			return ped
		end

---feature
a.tomoxingtaiguan = c.pdf("Pallbearers","action",a.opption,function(k,pid)

pos = player.get_player_coords(pid)
local pedp = player.get_player_ped(pid)
pos.z = pos.z + 0.6
coffin = object.create_object(2193278353,pos,true,false)
entity.attach_entity_to_entity(coffin,pedp, 0, v3(0,0,0.6), v3(0.0,0,0.0), true, true, false, 0, true)

npc1 = createped(26,0x9B22DBAF,pos,0)

entity.attach_entity_to_entity(npc1,coffin, 0, v3(0.25,0,-0.4),v3(0.0,0,0.0), true, true, false, 0, true)
entity.freeze_entity(npc1, true)


c.wait(1)
npc2 = createped(26,0x9B22DBAF,pos,0)
entity.attach_entity_to_entity(npc2,coffin, 0, v3(-0.25,0,-0.4),v3(0.0,0,0.0), true, true, false, 0, true)
entity.freeze_entity(npc2, true)
c.wait(1)


npc3 = createped(26,0x9B22DBAF,pos,0)
entity.attach_entity_to_entity(npc3,coffin, 0, v3(0.25,0.5,-0.4),v3(0.0,0,0.0), true, true, false, 0, true)
entity.freeze_entity(npc3, true)

c.wait(1)

npc4 = createped(26,0x9B22DBAF,pos,0)
entity.attach_entity_to_entity(npc4,coffin, 0, v3(-0.25,0.5,-0.4),v3(0.0,0,0.0), true, true, false, 0, true)
entity.freeze_entity(npc4, true)
c.wait(1)
npc5 = createped(26,0x9B22DBAF,pos,0)
entity.attach_entity_to_entity(npc5,coffin, 0, v3(0.22,-0.5,-0.4),v3(0.0,0,0.0), true, true, false, 0, true)
entity.freeze_entity(npc5, true)
c.wait(1)
npc6 = createped(26,0x9B22DBAF,pos,0)
entity.attach_entity_to_entity(npc6,coffin, 0, v3(-0.22,-0.5,-0.4),v3(0.0,0,0.0), true, true, false, 0, true)
entity.freeze_entity(npc6, true)
c.wait(1)
end)
