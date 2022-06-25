require("LightControl/settings") --requires the settings.lua

function isKeyDown(keyNum)  --53 s, 57 w, 41 a, 44 d
   local key = MenuKey()
   key:push_vk(keyNum)
   return key:is_down()
end

function round(number, decimalplaces)
   local mult = 10^(decimalplaces or 0)
   return math.floor(number * mult + 0.5) / mult
end

function contains(table, val, index) --checks till index of array
   for i=1, index do
      if table[i] == val then
         return true
      end
   end
   return false
end

function contains_return_index(table, val)
   for i=1, #table do
      if table[i] == val then
         return i
      end
   end
end

function contains2(table, val, index) --checks element in array[array]
   for i=1, #table do
      if table[i][index] == val then
         return true
      end
   end
   return false
end

function contains_return_index2(table, val, index)
   for i=1, #table do
      if table[i][index] == val then
         return i
      end
   end
end

function cross_product(a, b)
   return v3(a.y*b.z-(a.z*b.y) , a.z*b.x-(a.x*b.z), a.x*b.y-(a.y*b.x))
end

function scalar_product(a, b)
   return (a.x*b.x+a.y*b.y+a.z*b.z)
end

function vector_amount(c) --BETRAG
   return (math.sqrt(c.x^2+c.y^2+c.z^2))
end

function vector_angle(a, b)
   return 180/math.pi*math.abs( math.acos( scalar_product(a, b)/(vector_amount(a)*vector_amount(b)) ) )
end


function is_entity_between(a, b, pos) --entitypos
   if (a.x < b.x) then
      low_x = a.x
      high_x = b.x
   else
      high_x = a.x
      low_x = b.x
   end
   if (a.y < b.y) then
      low_y = a.y
      high_y = b.y
   else
      high_y = a.y
      low_y = b.y
   end
   if (pos.x > low_x and pos.x < high_x and pos.y > low_y and pos.y < high_y) then
      return true
   end
   return false
end


--Set Vehicle on Ground
function setVehicleonGround(veh)
   if (entity.is_entity_upside_down(veh)) then
      vehicle.set_vehicle_on_ground_properly(veh)
   end
end

--slow down Traffic function
function slow_down_traffic(speed)
   system.wait(100)
   allveh = vehicle.get_all_vehicles()
   local player_veh = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
   if (#allveh == 0 or nil) then return end
   for i = 1, #allveh do
      if (allveh[i] ~= player_veh) then
         entity.set_entity_max_speed(allveh[i], speed)
      end
   end
end

function Distance(Entity1, Entity2) --WIP
   local Entitypcoords1 = entity.get_entity_coords(Entity1)
   local Entitypcoords2 = entity.get_entity_coords(Entity2)

   _Distance = math.sqrt((Entitypcoords1.x - Entitypcoords2.x)^2+(Entitypcoords1.y - Entitypcoords2.y)^2+(Entitypcoords1.z - Entitypcoords2.z)^2)
   --_Vector = v3(Entitypcoords1.x - Entitypcoords2.x, Entitypcoords1.y - Entitypcoords2.y, Entitypcoords1.z - Entitypcoords2.z)
   return _Distance
end


function Distance2(Coords, Entity)
   local Entitypcoords = entity.get_entity_coords(Entity)
   return math.sqrt((Coords.x - Entitypcoords.x)^2+(Coords.y - Entitypcoords.y)^2)
end

function getvehvector()
   while not streaming.has_model_loaded(0x616C97B9) do
      streaming.request_model(0x616C97B9)
      system.wait(10)
   end
   local pos = player.get_player_coords(player.player_id())
   local player_veh = ped.get_vehicle_ped_is_using(OwnPedd)  --own vehicle
   local ownvehpos = entity.get_entity_coords(player_veh)
   local ped1 = ped.create_ped(6, 0x616C97B9, pos, pos.x, true, false)
   local ped2 = ped.create_ped(6, 0x616C97B9, pos, pos.x, true, false)
   local boneindex1 = entity.get_entity_bone_index_by_name(player_veh, "wheel_lf")
   local boneindex2 = entity.get_entity_bone_index_by_name(player_veh, "wheel_lr")
   entity.attach_entity_to_entity(ped1, player_veh, boneindex1, v3(0,0,0), v3(0,0,0), false, false, true, 0, false)
   entity.attach_entity_to_entity(ped2, player_veh, boneindex2, v3(0,0,0), v3(0,0,0), false, false, true, 0, false)
   pos1 = entity.get_entity_coords(ped1)
   pos2 = entity.get_entity_coords(ped2)
   network.request_control_of_entity(ped1)
   network.request_control_of_entity(ped2)
   entity.delete_entity(ped1)
   entity.delete_entity(ped2)
   --vector = v2(pos2.x-pos1.x, pos2.y-pos1.y)
   --Betrag = math.sqrt((pos2.x-pos1.x)^2+(pos2.y-pos1.y)^2)
end


function getcoordsofvehbone(bonename, vehicle)  --bonename: "exhaust"
   while not streaming.has_model_loaded(1803116220) do
      streaming.request_model(1803116220)
      system.wait(10)
   end
   local pos = player.get_player_coords(player.player_id())
   local helperobject = object.create_object(1803116220, pos, true, true)
   local boneindex = entity.get_entity_bone_index_by_name(vehicle, bonename)

   entity.attach_entity_to_entity(helperobject, vehicle, boneindex, v3(0,0,0), v3(0,0,0), true, true, false, 0, true)
   local _Bonecoords = entity.get_entity_coords(helperobject)
   network.request_control_of_entity(helperobject)
   entity.delete_entity(helperobject)
   return _Bonecoords
end


function AttatchObjecttoVehBone(bonenamestring, Vehicle, Objecthash, V3Offset, bool_invisible)

   while not streaming.has_model_loaded(Objecthash) do
      streaming.request_model(Objecthash)
      system.wait(10)
   end
   local pos = entity.get_entity_coords(Vehicle)
   local boneindex = entity.get_entity_bone_index_by_name(Vehicle, bonenamestring)
   --#### bool               attach_entity_to_entity(Entity subject, Entity target, int boneIndex, v3 offset, v3 rot, bool softPinning, bool collision, bool isPed, int vertexIndex, bool fixedRot)
   _Object = object.create_object(Objecthash, pos, true, true)
   entity.set_entity_visible(_Object, bool_invisible)
   entity.attach_entity_to_entity(_Object, Vehicle, boneindex, V3Offset, v3(0, 0, 0), true, true, false, 0, true)
   _Position = entity.get_entity_coords(_Object)
   return _Position
end

