local natives = require("Meteor/Lib/Natives")

local memory = {}

function memory.network_is_script_entity(Entity)
	if Entity and entity.is_an_entity(Entity) then
		if natives.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Entity):__tointeger() ~= 0 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function memory.network_entity_to_net(Entity)
    if Entity and entity.is_an_entity(Entity) then
		if entity.is_entity_a_ped(Entity) then
			return natives.PED_TO_NET(Entity):__tointeger()
		end
		if entity.is_entity_a_vehicle(Entity) then
			return natives.VEH_TO_NET(Entity):__tointeger()
		end
		if entity.is_entity_an_object(Entity) then
			return natives.OBJ_TO_NET(Entity):__tointeger()
		end
    end
end

function memory.read_bitset(NetID, bitset)
	if NetID then
		return NetID >> bitset
	end
end

function memory.get_entity_owner(Entity)
    if Entity and entity.is_an_entity(Entity) then
        if not ped.is_ped_a_player(Entity) then
			if not network.has_control_of_entity(Entity) then
				return memory.read_bitset(memory.network_entity_to_net(Entity), 16)
			else
				return player.player_id()
			end
        else
            return player.get_player_from_ped(Entity)
        end
    end
end

function memory.get_entity_creator(Entity)
    if Entity and entity.is_an_entity(Entity) then
		if memory.network_is_script_entity(Entity) then
			if not network.has_control_of_entity(Entity) then
				return memory.read_bitset(memory.network_entity_to_net(Entity), 16)
			else
				return player.player_id()
			end
        end
    end
end

return memory