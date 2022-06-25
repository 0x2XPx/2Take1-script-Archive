NETWORK = {}
CAM = {}
VEHICLE = {}
WEAPON = {}
ENTITY = {}
MONEY = {}
NETSHOPPING = {}
STATS = {}
PED = {}
OBJECT = {}
TASK = {}
PLAYER = {}
GRAPHICS = {}
HUD = {}

function HUD.CHANGE_FAKE_MP_CASH(cash, bank)
    return native.call(0x0772DF77852C2E30, cash, bank)
end

function NETWORK.GET_ONLINE_VERSION()
    return native.call(0xFCA9373EF340AC0A):__tostring(true)
end

function NETWORK.SET_RELATIONSHIP_TO_PLAYER(player, toggle)
    return native.call(0xA7C511FA1C5BDA38, player, toggle)
end

function NETWORK.NETWORK_IS_FRIEND(handle)
    return native.call(0x1A24A179F9B31654, handle)
end

function NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, netHandle, bufferSize)
    return native.call(0x388EB2B86C73B6B3, pid, netHandle, bufferSize)
end

function NETWORK.NETWORK_IS_PLAYER_CONNECTED(player)
    return native.call(0x93DC1BE4E1ABE9D1, player)
end

function PLAYER.PLAYER_PED_ID()
    return native.call(0xD80958FC74E988A6):__tointeger()
end

function CAM.GET_RENDERING_CAM()
    return native.call(0x5234F9F10919EABA)
end

function CAM.SET_CAM_FOV(cam, fov)
    return native.call(0xB13C14F66A00D047, cam, fov)
end

function CAM.DOES_CAM_EXIST(cam)
    return native.call(0xA7A932170592B50E, cam)
end

function CAM.CREATE_CAM_WITH_PARAMS(camName, posX, posY, posZ, rotX, rotY, rotZ, fov, active, rotationOrder)
    return native.call(0xB51194800B257161, camName, posX, posY, posZ, rotX, rotY, rotZ, fov, active, rotationOrder)
end

function CAM.ATTACH_CAM_TO_ENTITY(cam, entity, xOffset, yOffset, zOffset, isRelative)
    return native.call(0xFEDB7D269E8C60E3, cam, entity, xOffset, yOffset, zOffset, isRelative)
end

function CAM.RENDER_SCRIPT_CAMS(render, ease, easeTime, p3, p4)
    return native.call(0x07E5B515DB0636FC, render, ease, easeTime, p3, p4)
end

function CAM.SET_CAM_ACTIVE(Cam, active)
    return native.call(0x026FB97D0A425F84, Cam, active)
end

function VEHICLE.SET_TRAIN_SPEED(train, speed)
    return native.call(0xAA0BC91BE0B796E3, train, speed)
end

function VEHICLE.SET_TRAIN_CRUISE_SPEED(train, speed)
    return native.call(0x16469284DB8C62B5, train, speed)
end

function VEHICLE.SET_RENDER_TRAIN_AS_DERAILED(train, toggle)
    return native.call(0x317B11A312DF5534, train, toggle)
end

function VEHICLE.CREATE_MISSION_TRAIN(variation, x, y, z, direction)
    return native.call(0x63C6CCA8E68AE8C8, variation, x, y, z, direction)
end

function VEHICLE.DELETE_MISSION_TRAIN()
    return native.call(0x5B76B14AE875C795)
end

function VEHICLE.DELETE_ALL_TRAINS()
    return native.call(0x736A718577F39C7D)
end

function VEHICLE.BRING_VEHICLE_TO_HALT(vehicle, distance, duration, unknown)
    return native.call(0x260BE8F09E326A20, vehicle, distance, duration, unknown)
end

function VEHICLE.SET_VEHICLE_UNDRIVEABLE(vehicle, toggle)
    return native.call(0x8ABA6AF54B942B95, vehicle, toggle)
end

function VEHICLE.SET_VEHICLE_DOOR_BROKEN (veh, door, broken)
    return native.call(0xD4D4F6A4AB575A33, veh, door, broken)
end

function VEHICLE.SWITCH_TRAIN_TRACK(trackId, state)
    return native.call(0xFD813BB7DB977F20, trackId, state)
end

function VEHICLE.SET_VEHICLE_DROPS_MONEY_WHEN_BLOWN_UP(vehicle, toggle)
    return native.call(0x068F64F2470F9656, vehicle, toggle)
end

function PED.SET_PED_HEARING_RANGE(ped, value)
    return native.call(0x33A8F7F7D5F7F33C, ped, value)
end

function PED.GET_PED_ALERTNESS(ped)
    return native.call(0xF6AA118530443FD2, ped)
end

function PED.SET_PED_AS_COP(ped, toggle)
    return native.call(0xBB03C38DD3FB7FFD, ped, toggle)
end

function PED.SET_PED_CONFIG_FLAG(ped, flagId, value)
    return native.call(0x1913FE4CBF41C463, ped, flagId, value)   
end

function ENTITY.SET_ENTITY_PROOFS(entity, bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, drownProof)
    return native.call(0xFAEE099C6F890BB8, entity, bulletProof, fireProof, explosionProof, collisionProof, meleeProof, steamProof, p7, drownProof)
end

function ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(entity)
    return native.call(0x1DD55701034110E5, entity)
end

function ENTITY.SET_ENTITY_ALPHA(entity, alphaLevel, skin)
    return native.call(0x44A0870B7E92D7C0, entity, alphaLevel, skin)
end

function ENTITY.RESET_ENTITY_ALPHA(entity)
    return native.call(0x9B1E824FFBB7027A, entity)
end

function ENTITY.SET_ENTITY_TRAFFICLIGHT_OVERRIDE(entity, state)
    return native.call(0x57C5DB656185EAC4, entity, state)
end

function ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(entity, boneName)
   return native.call(0xFB71170B7E76ACBA, entity, boneName):__tointeger()
end

function ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(entity, boneIndex)
    return native.call(0x44A8FCB8ED227738, entity, boneIndex):__tov3()
end

function ENTITY.GET_ENTITY_PITCH(entity)
   return native.call(0xD45DC2893621E1FE, entity)
end

function ENTITY.GET_ENTITY_HEADING(entity)
   return native.call(0xE83D4F9BA2A38914, entity)
end

function OBJECT.CREATE_AMBIENT_PICKUP(pickupHash, posX, posY, posZ, flags, value, modelHash, p7, p8)    
    return native.call(0x673966A0C0FD7171, pickupHash, posX, posY, posZ, flags, value, modelHash, p7, p8) 
end


function MONEY.NETWORK_GET_VC_WALLET_BALANCE(charSlot)
    return native.call(0xA40F9C2623F6A8B5, charSlot):__tointeger()
end    

function MONEY.NETWORK_GET_VC_BANK_BALANCE()
    return native.call(0x76EF28DA05EA395A):__tointeger()
end    



function NETSHOPPING.NET_GAMESERVER_TRANSFER_BANK_TO_WALLET(charSlot, amount)
    return native.call(0xD47A2C1BA117471D, charSlot, amount)
end    

function NETSHOPPING.NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(charSlot, amount)
    return native.call(0xC2F7FE5309181C7D, charSlot, amount)
end    


function STATS.GET_PACKED_BOOL_STAT_KEY(index, spStat, charStat, character)
    return native.call(0x80C75307B1C42837, index, spStat, charStat, character)
end

function STATS.GET_PACKED_INT_STAT_KEY(index, spStat, charStat, character)
    return native.call(0x61E111E323419E07, index, spStat, charStat, character)
end

function STATS.SET_PACKED_STAT_BOOL(index, value, characterSlot)
    return native.call(0xDB8A58AEAA67CD07, index, value, characterSlot)
end

function STATS.SET_PACKED_STAT_INT(index, value, characterSlot)
    return native.call(0x1581503AE529CD2E, index, value, characterSlot)
end

function STATS.STAT_INCREMENT(statName, value)
    return native.call(0x9B5A68C6489E9909, statName, value)
end

function STATS.STAT_GET_DATE(statHash, p1, p2, p3)
    return native.call(0x9B5A68C6489E9909, statHash, p1, p2, p3)
end

function STATS.STAT_SET_DATE(statName, value, numFields, save)
    return native.call(0x9B5A68C6489E9909, statName, value, numFields, save)
end


function TASK.TASK_WARP_PED_INTO_VEHICLE(ped, vehicle, seat)
    return native.call(0x9A7D091411C5F684, ped, vehicle, seat)
end

function TASK.TASK_SHUFFLE_TO_NEXT_VEHICLE_SEAT(ped, vehicle, p2) 
    return native.call(0x7AA80209BDA643EB, ped, vehicle, p2)
end


function GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(r, g, b)
    return native.call(0x26143A59EF48B262, r, g, b)
end

function GRAPHICS.USE_PARTICLE_FX_ASSET(name)
    native.call(0x6C38AF3693A69A91, name)
end

function GRAPHICS.START_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(effectName, entity, xOffset, yOffset, zOffset, xRot, yRot, zRot, boneIndex, scale, xAxis, yAxis, zAxis)
    return native.call(0xC6EB449E33977F0B, effectName, entity, xOffset, yOffset, zOffset, xRot, yRot,zRot, boneIndex, scale, xAxis, yAxis, zAxis)
end

function GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(effectName, xPos, yPos, zPos, xRot, yRot, zRot, scale, xAxis, yAxis, zAxis)
  return native.call(0xF56B8137DF10135D, effectName, xPos, yPos, zPos, xRot, yRot, zRot, scale, xAxis, yAxis, zAxis) 
end

function GRAPHICS.REQUEST_NAMED_PTFX_ASSET(fxName)
    native.call(0xB80D8756B4668AB6, fxName)
end

function GRAPHICS.HAS_NAMED_PTFX_ASSET_LOADED(fxName) 
    return native.call(0x8702416E512EC454, fxName)
end

function GRAPHICS.SET_NIGHTVISION(toggle)
    return native.call(0x18F621F7A5B1F85D, toggle)
end

function GRAPHICS.SET_HEATVISION(toggle)
    return native.call(0x7E08924259E08CE0, toggle)
end

function WEAPON.GET_CURRENT_PED_WEAPON(ped, weaponHash, p2)
    return native.call(0x3A87E44BB9A01D54, ped, weaponHash, p2)
end