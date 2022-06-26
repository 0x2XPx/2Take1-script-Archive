local vm = require("ZeroMenuLib/enums/VehicleMapper")
local om = require("ZeroMenuLib/enums/ObjectMapper")
local pm = require("ZeroMenuLib/enums/PedMapper")

local vb = require("ZeroMenuLib/enums/VehicleBones")
local pb = require("ZeroMenuLib/enums/PedBones")

local xml2lua = require("xml2lua")
local xmlhandler = require("xmlhandler.tree")
  
local vehicleBuilder, spawnVehicle, spawnPed
local spawnedVehicleList,spawnedObjectList, spawnedPedList, vehicleParentList, pedParentList, objectParentList

local featToEntity
local xmlList = nil

function createVehicleBuilderEntry(parent,config)
  vehicleBuilder = menu.add_feature("Vehicle Builder","parent",parent.id,loadVehicles)  
  spawnVehicle = menu.add_feature("Spawn Vehicle","action",vehicleBuilder.id,spawnVehicle)  
  spawnVehicle = menu.add_feature("Spawn XML Vehicle","action",vehicleBuilder.id,spawnXML)  
  spawnVehicle = menu.add_feature("Spawn Object by Hash","action",vehicleBuilder.id,spawnObjectByHash)  
  spawnVehicle = menu.add_feature("Spawn Object by Name","action",vehicleBuilder.id,spawnObjectByName)  
  spawnPed = menu.add_feature("Spawn Ped by Name","action",vehicleBuilder.id,spawnPedByName)
    
  vehicleParentList = menu.add_feature("Vehicles","parent",vehicleBuilder.id,nil)  
  pedParentList = menu.add_feature("Peds","parent",vehicleBuilder.id,nil)  
  
  menu.add_feature("Add own Ped","action",pedParentList.id,
  function()
    local pedData = {}      
    --table.insert(spawnedPedList,player.get_player_ped(player.player_id()))
    pedData['name'] = player.get_player_name(player.player_id())
    pedData['id'] = player.get_player_ped(player.player_id())
    spawnedPedList[#spawnedPedList+1] = pedData
    processSpawnedPed(pedData)
    menu.notify("Added Own Ped to List","ZeroMenu",5,140) 
  end)  
  
  menu.add_feature("Add Vehicle","action",vehicleParentList.id,
  function()
    if(player.is_player_in_any_vehicle(player.player_id())) then
      local vehicleData = {}
      local hash = entity.get_entity_model_hash(player.get_player_vehicle(player.player_id()))
      local vehicleName = vm.GetNameFromHash(hash)
      if(vehicleName == nil) then vehicleName = "Unknown Vehicle" end
      vehicleData['name'] = vehicleName
      vehicleData['hash'] = hash 
      vehicleData['id'] = player.get_player_vehicle(player.player_id())
      local arrayID = #spawnedVehicleList+1
      vehicleData['arrayID'] = arrayID
      spawnedVehicleList[arrayID] = vehicleData
      processSpawnedVehicle(vehicleData)
      menu.notify("Added Own Vehicle to List","ZeroMenu",5,140)
    else    
      menu.notify("Please enter a vehicle first!","ZeroMenu",5,140)
    end
    
  end)  
  
  objectParentList = menu.add_feature("Objects","parent",vehicleBuilder.id,nil)  
  
  spawnedVehicleList = {}
  spawnedObjectList = {}
  spawnedPedList = {}
  featToEntity  = {}
end

function notifySpawnedStuff()
  menu.notify("Spawned " .. #spawnedVehicleList .. " Vehicles\n" .. "Spawned " .. #spawnedObjectList ..  " Objects\n" .. "Spawned " .. #spawnedPedList ..     " Peds","ZeroMenu",5,140) 
end

function processSpawnedVehicle(vehicleData)
  --vehicleParentList  
  local tempFeature = menu.add_feature(vehicleData['name'] .. "(" .. vehicleData['id'] .. ")","parent",vehicleParentList.id,nil)
  local attachSettings = menu.add_feature("Attach Settings","parent",tempFeature.id,nil)
  
  menu.add_feature("-- Offset -- ","action",attachSettings.id,nil)
  local offsetX = menu.add_feature("X","autoaction_value_i",attachSettings.id,nil)
  offsetX.min = -500
  offsetX.max = 500
  local offsetY = menu.add_feature("Y","autoaction_value_i",attachSettings.id,nil)
  offsetY.min = -500
  offsetY.max = 500
  local offsetZ = menu.add_feature("Z","autoaction_value_i",attachSettings.id,nil)
  offsetZ.min = -500
  offsetZ.max = 500
  
  menu.add_feature("-- Rotation -- ","action",attachSettings.id,nil)
  local rotationX = menu.add_feature("X","autoaction_value_i",attachSettings.id,nil)
  rotationX.min = 0
  rotationX.max = 365
  local rotationY = menu.add_feature("Y","autoaction_value_i",attachSettings.id,nil)
  rotationY.min = 0
  rotationY.max = 365
  local rotationZ = menu.add_feature("Z","autoaction_value_i",attachSettings.id,nil)
  rotationZ.min = 0
  rotationZ.max = 365
  
  -- Attach PTFX
  local attachptfx = menu.add_feature("Attach PTFX","action",tempFeature.id,attach_ptfx)
  attachptfx.data = {entity = vehicleData['id'],parentSettings = attachSettings}
  --Attach Vehicle
  local attachVehicle = menu.add_feature("Attach Vehicle","parent",tempFeature.id,loadAttachAbleVehicleList)
  attachVehicle.data = {entity = vehicleData,parentSettings = attachSettings,type = "vehicle"}
  --Attach Object
  local attachObject = menu.add_feature("Attach Object","parent",tempFeature.id,loadAttachAbleObjectList)
  attachObject.data = {entity = vehicleData,parentSettings = attachSettings,type = "vehicle"}
  --Attach Ped
  local attachPed = menu.add_feature("Attach Ped","parent",tempFeature.id,loadAttachAblePedList)
  attachPed.data = {entity = vehicleData,parentSettings = attachSettings,type = "vehicle"}
    
  --Delete
  menu.add_feature("Delete","action",tempFeature.id,
  function()
    entity.delete_entity(vehicleData['id'])
    menu.notify("Deleted " .. vehicleData['name'] ..  " (" .. vehicleData['id'] .. ")","ZeroMenu",5,140)  
    for i=1,#tempFeature.children do
      menu.delete_feature(tempFeature.children[1].id)
    end
    menu.delete_feature(tempFeature.id)    
    table.remove(spawnedVehicleList,vehicleData['arrayID'])
  end)  
end

function processSpawnedObject(objectData)
  --vehicleParentList  
  local tempFeature = menu.add_feature(objectData['name'] .. "(" .. objectData['id'] .. ")","parent",objectParentList.id,nil)
  local attachSettings = menu.add_feature("Attach Settings","parent",tempFeature.id,nil)
  
  menu.add_feature("-- Offset -- ","action",attachSettings.id,nil)
  local offsetX = menu.add_feature("X","autoaction_value_i",attachSettings.id,nil)
  offsetX.min = -500
  offsetX.max = 500
  local offsetY = menu.add_feature("Y","autoaction_value_i",attachSettings.id,nil)
  offsetY.min = -500
  offsetY.max = 500
  local offsetZ = menu.add_feature("Z","autoaction_value_i",attachSettings.id,nil)
  offsetZ.min = -500
  offsetZ.max = 500
  
  menu.add_feature("-- Rotation -- ","action",attachSettings.id,nil)
  local rotationX = menu.add_feature("X","autoaction_value_i",attachSettings.id,nil)
  rotationX.min = 0
  rotationX.max = 365
  local rotationY = menu.add_feature("Y","autoaction_value_i",attachSettings.id,nil)
  rotationY.min = 0
  rotationY.max = 365
  local rotationZ = menu.add_feature("Z","autoaction_value_i",attachSettings.id,nil)
  rotationZ.min = 0
  rotationZ.max = 365
  
  -- Attach PTFX
  local attachptfx = menu.add_feature("Attach PTFX","action",tempFeature.id,attach_ptfx)
  attachptfx.data = {entity = objectData['id'],parentSettings = attachSettings,type = "object"}
  --Attach Vehicle
  local attachVehicle = menu.add_feature("Attach Vehicle","parent",tempFeature.id,loadAttachAbleVehicleList)
  attachVehicle.data = {entity = objectData,parentSettings = attachSettings,type = "object"}
  --Attach Object
  local attachObject = menu.add_feature("Attach Object","parent",tempFeature.id,loadAttachAbleObjectList)
  attachObject.data = {entity = objectData,parentSettings = attachSettings,type = "object"}
  --Attach Ped
  local attachPed = menu.add_feature("Attach Ped","parent",tempFeature.id,loadAttachAblePedList)
  attachPed.data = {entity = objectData,parentSettings = attachSettings}
    
  --Delete
  menu.add_feature("Delete","action",tempFeature.id,
  function()
    entity.delete_entity(objectData['id'])
    menu.notify("Deleted " .. objectData['name'] ..  " (" .. objectData['id'] .. ")","ZeroMenu",5,140)    
    for i=1,#tempFeature.children do
      menu.delete_feature(tempFeature.children[1].id)
    end
    menu.delete_feature(tempFeature.id)    
    table.remove(spawnedVehicleList,objectData['arrayID'])
  end)  
end

function processSpawnedPed(pedData)
  --vehicleParentList  
  local tempFeature = menu.add_feature(pedData['name'] .. "(" .. pedData['id'] .. ")","parent",pedParentList.id,nil)
  local attachSettings = menu.add_feature("Attach Settings","parent",tempFeature.id,nil)
  
  menu.add_feature("-- Offset -- ","action",attachSettings.id,nil)
  local offsetX = menu.add_feature("X","autoaction_value_i",attachSettings.id,nil)
  offsetX.min = -500
  offsetX.max = 500
  local offsetY = menu.add_feature("Y","autoaction_value_i",attachSettings.id,nil)
  offsetY.min = -500
  offsetY.max = 500
  local offsetZ = menu.add_feature("Z","autoaction_value_i",attachSettings.id,nil)
  offsetZ.min = -500
  offsetZ.max = 500
  
  menu.add_feature("-- Rotation -- ","action",attachSettings.id,nil)
  local rotationX = menu.add_feature("X","autoaction_value_i",attachSettings.id,nil)
  rotationX.min = 0
  rotationX.max = 365
  local rotationY = menu.add_feature("Y","autoaction_value_i",attachSettings.id,nil)
  rotationY.min = 0
  rotationY.max = 365
  local rotationZ = menu.add_feature("Z","autoaction_value_i",attachSettings.id,nil)
  rotationZ.min = 0
  rotationZ.max = 365
  
  -- Attach PTFX
  local attachptfx = menu.add_feature("Attach PTFX","action",tempFeature.id,attach_ptfx)
  attachptfx.data = {entity = pedData['id'],parentSettings = attachSettings,type = "ped"}
  --Attach Vehicle
  local attachVehicle = menu.add_feature("Attach Vehicle","parent",tempFeature.id,loadAttachAbleVehicleList)
  attachVehicle.data = {entity = pedData,parentSettings = attachSettings,type = "ped"}
  --Attach Object
  local attachObject = menu.add_feature("Attach Object","parent",tempFeature.id,loadAttachAbleObjectList)
  attachObject.data = {entity = pedData,parentSettings = attachSettings,type = "ped"}
  --Attach Ped
  local attachPed = menu.add_feature("Attach Ped","parent",tempFeature.id,loadAttachAblePedList)
  attachPed.data = {entity = pedData,parentSettings = attachSettings}
    
  --Delete
  menu.add_feature("Delete","action",tempFeature.id,
  function()
    entity.delete_entity(pedData['id'])  
    menu.notify("Deleted " .. pedData['name'] ..  " (" .. pedData['id'] .. ")","ZeroMenu",5,140)    
    for i=1,#tempFeature.children do
      menu.delete_feature(tempFeature.children[1].id)
    end
    menu.delete_feature(tempFeature.id)    
    table.remove(spawnedVehicleList,pedData['arrayID'])
  end)
end

function loadAttachAbleVehicleList(feat,data)
  local parent = data.entity
  for i=1,#spawnedVehicleList do
    if(isChild(feat,tostring(spawnedVehicleList[i]['name'] .. " (" .. spawnedVehicleList[i]['id'] .. ")")) == false) then
      if(spawnedVehicleList[i]['id'] ~= parent['id']) then
        local attachVehicleFunc = menu.add_feature(spawnedVehicleList[i]['name'] .. " (" .. spawnedVehicleList[i]['id'] .. ")","action_value_str",feat.id,attachVehicle)
        attachVehicleFunc.data = {parentVehicleObject = parent,parentVehicle = parent['id'], childVehicle = spawnedVehicleList[i]['id'],parentSettings = data.parentSettings}      
        local bones = nil
        if(data.type == "vehicle") then
          bones = vb.GetUseAbleBones(parent['id'])
        elseif(data.type == "ped") then
          bones = pb.GetUseAbleBones(parent['id'])
        else
          bones = {"center"}          
        end
        attachVehicleFunc.set_str_data(attachVehicleFunc,bones)
        
        --Save feat for deleting later
        local featList = spawnedVehicleList[i]['feats']  
        if(featList == nil) then
          spawnedVehicleList[i]['feats'] = {}
        end
        local featList = spawnedVehicleList[i]['feats']  
        featList[#featList+1] = attachVehicleFunc
      end
    end
  end
end

function loadAttachAblePedList(feat,data)
  local parent = data.entity
  for i=1,#spawnedPedList do
    if(isChild(feat,tostring(spawnedPedList[i]['name'] .. " (" .. spawnedPedList[i]['id'] .. ")")) == false) then
      if(spawnedPedList[i]['id'] ~= parent['id']) then
        local attachVehicleFunc = menu.add_feature(spawnedPedList[i]['name'] .. " (" .. spawnedPedList[i]['id'] .. ")","action_value_str",feat.id,attachVehicle)
        attachVehicleFunc.data = {parentVehicleObject = parent,parentVehicle = parent['id'], childVehicle = spawnedPedList[i]['id'],parentSettings = data.parentSettings}      
        
        print("loadAttachAblePedList: Getting Bones for " .. parent['id'])
        local bones = {"center"}
        if(data.type == "vehicle") then
          bones = vb.GetUseAbleBones(parent['id'])
        elseif(data.type == "ped") then
          bones = pb.GetUseAbleBones(parent['id'])
        else
          bones = {"center"}          
        end
        
        attachVehicleFunc.set_str_data(attachVehicleFunc,bones)
        
        --Save feat for deleting later
        local featList = spawnedPedList[i]['feats']  
        if(featList == nil) then
          spawnedPedList[i]['feats'] = {}
        end
        local featList = spawnedPedList[i]['feats']  
        featList[#featList+1] = attachVehicleFunc
      end
    end
  end
end

function loadAttachAbleObjectList(feat,data)
  local parent = data.entity
  for i=1,#spawnedObjectList do
    if(isChild(feat,tostring(spawnedObjectList[i]['name'] .. " (" .. spawnedObjectList[i]['id'] .. ")")) == false) then
      if(spawnedObjectList[i]['id'] ~= parent['id']) then
        local attachVehicleFunc = menu.add_feature(spawnedObjectList[i]['name'] .. " (" .. spawnedObjectList[i]['id'] .. ")","action_value_str",feat.id,attachVehicle)
        attachVehicleFunc.data = {parentVehicleObject = parent,parentVehicle = parent['id'], childVehicle = spawnedObjectList[i]['id'],parentSettings = data.parentSettings}      
        local bones = {"center"}     
        print("searching for a bone for type: " .. data.type)    
        print("loadAttachAbleObjectList: Getting Bones for " .. parent['id'])
        
        if(data.type == "vehicle") then
          print("type: vehicle")
          bones = vb.GetUseAbleBones(parent['id'])
        elseif(data.type == "ped") then
          print("type: ped")
          bones = pb.GetUseAbleBones(parent['id'])
        else
          bones = {"center"}          
        end        
        attachVehicleFunc.set_str_data(attachVehicleFunc,bones)
        menu.notify("Found " .. #bones .. " Bones for " .. parent['id'],"ZeroMenu",5,140)    
        --Save feat for deleting later
        local featList = spawnedObjectList[i]['feats']  
        if(featList == nil) then
          spawnedObjectList[i]['feats'] = {}
        end
        local featList = spawnedObjectList[i]['feats']  
        featList[#featList+1] = attachVehicleFunc
      end
    end
  end
end

function isChild(parentFeat,name)
   for i=1,#parentFeat.children do
      if(parentFeat.children[i].name == name) then
        return true
      end
   end
   return false
end

function attachVehicle(feat,data)

  local offsetX = data.parentSettings.children[2].value
  local offsetY = data.parentSettings.children[3].value
  local offsetZ = data.parentSettings.children[4].value
  
  local rotationX = data.parentSettings.children[6].value
  local rotationY = data.parentSettings.children[7].value
  local rotationZ = data.parentSettings.children[8].value

  local offset = v3(offsetX,offsetY,offsetZ)
  local rot = v3(rotationX,rotationY,rotationZ)
  local bone = nil
  if(data.type == "vehicle") then
    bone = entity.get_entity_bone_index_by_name(data.parentVehicle,vb.GetUseAbleBones(data.parentVehicle)[feat.value+1])
  elseif(data.type == "ped") then
    bone = entity.get_entity_bone_index_by_name(data.parentVehicle,pb.GetUseAbleBones(data.parentVehicle)[feat.value+1])
  else
    bone = 0
  end
  entity.attach_entity_to_entity(data.childVehicle,data.parentVehicle,bone,offset,rot,false,true,false,0,true)
  
  --make everything no collideable to each other
  
  local attachedStuff = data.parentVehicleObject['attachedStuff']
  
  if(attachedStuff == nil) then
    attachedStuff = {}
  end
  attachedStuff[#attachedStuff+1] = data.childVehicle
  data.parentVehicleObject['attachedStuff'] = attachedStuff
  
  for i=1,#attachedStuff do
    local entityX = attachedStuff[i]
    for i=1,#attachedStuff do
      entity.set_entity_no_collsion_entity(attachedStuff[i],entityX,true)
    end
  end
end

local requestedVehicle = nil
function spawnVehicle()
  local rightHash = nil  
  if requestedVehicle == nil then
    local r, s = input.get("Enter Vehicle", "tampa", 64, 0)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end    
    requestedVehicle = s
  end
  
  local HashByName = vm.GetHashFromName(requestedVehicle)
  local HashByModel = vm.GetHashFromModel(requestedVehicle)
            
  if(HashByName ~= nil)then
    rightHash = HashByName
  end
  if(HashByModel ~= nil)then
    rightHash = HashByModel
  end 
  
  if(rightHash == nil or streaming.is_model_in_cdimage(rightHash) == false) then
        menu.notify("Unknown Hash!","ZeroMenu",5,140)    
      requestedVehicle = nil
      return HANDLER_POP
  end
  
  if(rightHash ~= nil) then
    if(streaming.has_model_loaded(rightHash)) then
      local v3 = player.get_player_coords(player.player_id())
      local vehicleData = {}
      vehicleData['hash'] = rightHash
      vehicleData['name'] = requestedVehicle
      --vehicleData['id'] = vehicle.create_vehicle(rightHash,v3,entity.get_entity_heading(player.get_player_ped(player.player_id())),true,false)
      vehicleData['id'] = spawnRawVehicle(rightHash,v3)
      local arrayID = #spawnedVehicleList+1
      vehicleData['arrayID'] = arrayID
      spawnedVehicleList[arrayID] = vehicleData
      streaming.set_model_as_no_longer_needed(rightHash)
      requestedVehicle = nil
      menu.notify("Spawned Vehicle " .. rightHash,"ZeroMenu",5,140)         
      notifySpawnedStuff()
      processSpawnedVehicle(vehicleData)
    else
      while not streaming.has_model_loaded(rightHash) do
          streaming.request_model(rightHash)
          system.wait(0)
      end
      return HANDLER_CONTINUE
    end
  end
end

function spawnRawVehicle(rightHash, v3)
  return vehicle.create_vehicle(rightHash,v3,entity.get_entity_heading(player.get_player_ped(player.player_id())),true,false)
end

local requestedPed = nil
function spawnPedByName()
  local rightHash = nil
  if requestedPed == nil then
    local r, s = input.get("Enter Ped Name", "Cow", 64, 0)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end    
    requestedPed = s
  end
  
  local HashByName = pm.GetHashFromName(requestedPed)
  local HashByModel = pm.GetHashFromModel(requestedPed)
            
  if(HashByName ~= nil)then
    rightHash = HashByName
  end
  if(HashByModel ~= nil)then
    rightHash = HashByModel
  end 
  
  if(rightHash ~= nil) then
    if(streaming.has_model_loaded(rightHash)) then
      local v3 = player.get_player_coords(player.player_id())
      local pedData = {}
      pedData['hash'] = rightHash
      pedData['name'] = requestedPed      
      pedData['id'] = ped.create_ped(0,rightHash,v3,entity.get_entity_heading(player.get_player_ped(player.player_id())),true,false)
      spawnedPedList[#spawnedPedList+1] = pedData
      streaming.set_model_as_no_longer_needed(rightHash)
      menu.notify("Spawned Ped " .. requestedPed,"ZeroMenu",5,140)     
      processSpawnedPed(pedData)
      notifySpawnedStuff()
      requestedPed = nil
    else
      while not streaming.has_model_loaded(rightHash) do
          streaming.request_model(rightHash)
          system.wait(0)
      end
      return HANDLER_CONTINUE
    end
  else    
      menu.notify("Unknown Ped " .. requestedPed,"ZeroMenu",5,140)  
      requestedPed = nil
  end
end

local requestedObject = 0
function spawnObjectByName()
  if requestedObject == 0 then
    local r, s = input.get("Enter Object Name", "hei_prop_heist_safedepdoor", 64, 0)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end
    requestedObject = s
  end
  local objectData = {}
  
  local objectHash = om.GetHashFromModel(requestedObject)
  
  if(streaming.has_model_loaded(objectHash)) then  
    local objectCandle
    if(streaming.is_model_a_world_object(objectHash)) then
      objectCandle = object.create_world_object(objectHash,player.get_player_coords(player.player_id()),true,true)
    else
      objectCandle = object.create_object(objectHash,player.get_player_coords(player.player_id()),true,true)
    end
    
    requestedObject = 0
    streaming.set_model_as_no_longer_needed(objectHash) 
    menu.notify("Spawned Object " .. requestedObject,"ZeroMenu",5,140)  
    count = 0
    objectData['id'] =  objectCandle
  else
    while not streaming.has_model_loaded(objectHash) do
      streaming.request_model(objectHash)
      system.wait(0)
    end 
    return HANDLER_CONTINUE
  end
  if(streaming.is_model_in_cdimage(objectHash) == false) then  
      menu.notify("Unknown Hash1 " .. requestedObject,"ZeroMenu",5,140)   
      requestedVehicle = nil
      return HANDLER_POP
  end
  
  if(objectData['id'] == nil) then
      menu.notify("Unknown Hash2 " .. requestedObject,"ZeroMenu",5,140)  
      requestedVehicle = nil
      return HANDLER_POP
  end
  objectData['hash'] = om.GetHashFromModel(requestedObject)
  objectData['name'] = requestedObject
  spawnedObjectList[#spawnedObjectList+1] = objectData
  menu.notify("Spawned " .. requestedObject,"ZeroMenu",5,140)  
  processSpawnedObject(objectData)
  notifySpawnedStuff()
  requestedObject = 0
end

function spawnObjectByHash()
  if requestedObject == 0 then
    local r, s = input.get("Enter Object Hash", "", 64, 3)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end
    requestedObject = tonumber(s)
  end
  if(streaming.is_model_in_cdimage(requestedObject) == false) then
      menu.notify("Unknown Hash " .. requestedObject,"ZeroMenu",5,140)    
      requestedObject = nil
      return HANDLER_POP
  end
  if(requestedObject == nil) then
      menu.notify("Unknown Hash " .. requestedObjec,"ZeroMenu",5,140)    
      requestedObject = nil
      return HANDLER_POP
  end
  local objectData = {}
  if(streaming.has_model_loaded(requestedObject)) then  
    local objectCandle
    if(streaming.is_model_a_world_object(requestedObject)) then
      objectCandle = object.create_world_object(requestedObject,player.get_player_coords(player.player_id()),true,true)
    else 
      objectCandle = object.create_object(requestedObject,player.get_player_coords(player.player_id()),true,true)
    end
    streaming.set_model_as_no_longer_needed(requestedObject) 
    menu.notify("Spawned Object " .. requestedObject,"ZeroMenu",5,140)    
    count = 0
    objectData['id'] =  objectCandle
  else
    while not streaming.has_model_loaded(requestedObject) do
      streaming.request_model(requestedObject)
      system.wait(0)
    end 
    return HANDLER_CONTINUE
  end
  print("1: " .. requestedObject)
  print("2: " .. om.GetModelFromHash(requestedObject))
  objectData['hash'] = requestedObject
  objectData['name'] = om.GetModelFromHash(requestedObject)
  spawnedObjectList[#spawnedObjectList+1] = objectData
  requestedObject = nil  
  menu.notify("Spawned " .. objectData['name'],"ZeroMenu",5,140)    
  processSpawnedObject(objectData)
  notifySpawnedStuff()
end


local dict = nil
local flame = nil
function attach_ptfx(feat,data)  
  local entity = data.entity
  
  local offsetX = data.parentSettings.children[2].value
  local offsetY = data.parentSettings.children[3].value
  local offsetZ = data.parentSettings.children[4].value
  
  local rotationX = data.parentSettings.children[6].value
  local rotationY = data.parentSettings.children[7].value
  local rotationZ = data.parentSettings.children[8].value
  
  if(dict == nil) then
    local r, s = input.get("Enter Dictonary", "core", 64, 0)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end    
    dict = s  
  end
    
  if(flame == nil) then
    local r, s = input.get("Enter PTFX", "ent_amb_candle_flame", 64, 0)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end      
    flame = s
  end
    
  local r, s = input.get("Enter Scale Value for PTFX", 5.0, 64, 5)
  if r == 1 then return HANDLER_CONTINUE end
  if r == 2 then return HANDLER_POP end      
  local scale = s
    
  graphics.set_next_ptfx_asset(dict)
  while not graphics.has_named_ptfx_asset_loaded(dict) do
    graphics.request_named_ptfx_asset(dict)
    system.wait(0)
    return HANDLER_CONTINUE 
  end
    
  local offset = v3(offsetX,offsetY,offsetZ)
  local rot = v3(rotationX,rotationY,rotationZ)
  graphics.start_networked_ptfx_looped_on_entity(flame,entity,offset,rot,scale)
  flame = nil
  dict = nil
  return HANDLER_POP 
end


local xmlFile = nil
function spawnXML()
  xmlList = {}
  if(xmlFile == nil) then
    local r, s = input.get("Enter an XML to spawn", "NuclearRocket", 64, 0)
    if r == 1 then return HANDLER_CONTINUE end
    if r == 2 then return HANDLER_POP end    
    xmlFile = os.getenv('APPDATA') .. "\\PopstarDevs\\2Take1Menu\\scripts\\ZeroMenuLib\\data\\xmlvehicles\\" .. s .. ".xml"    
    local testF = io.open(xmlFile,"r")
    if(testF ~= nil and xmlFile~=nil) then
      io.close(testF)
      local handler = loadXMLFile(xmlFile)
      print(handler)
      print(handler.root)
      print(handler.root.Vehicle)
      print(handler.root.Vehicle.ModelHash)
      local vehicleHash = tonumber(handler.root.Vehicle.ModelHash:sub(3), 16)
      local vehicle = nil
      while not streaming.has_model_loaded(vehicleHash) do
        streaming.request_model(vehicleHash )
        system.wait(0)
      end
      local v3 = player.get_player_coords(player.player_id())
                
      vehicle = spawnRawVehicle(vehicleHash,player.get_player_coords(player.player_id()))
      entity.freeze_entity(vehicle,true)
      menu.notify(" spawned " .. vehicle,"ZeroMenu",5,140)
      streaming.set_model_as_no_longer_needed(vehicleHash)
      xmlList[handler.root.Vehicle.InitialHandle] = vehicle
      processXMLVehileProberties(vehicle,handler.root.Vehicle.VehicleProperties,handler)
      processAttachment(handler.root.Vehicle.SpoonerAttachments.Attachment,handler)
      menu.notify(s .. " spawned","ZeroMenu",5,140)
      xmlFile = nil    
      entity.freeze_entity(vehicle,false)
    else
      menu.notify("File '" .. xmlFile .. "' not found","ZeroMenu",5,140)
      xmlFile = nil
    end
  end
end

function processXMLVehileProberties(xmlvehicle,proberties,handler)
  vehicle.set_vehicle_colors(xmlvehicle,valueOrDefault(proberties.Colours.Primary,0),valueOrDefault(proberties.Colours.Secondary,0))
  vehicle.set_vehicle_custom_pearlescent_colour(xmlvehicle,valueOrDefault(proberties.Colours.Pearl,0))
  vehicle.set_vehicle_extra_colors(xmlvehicle,valueOrDefault(proberties.Colours.Pearl,0),valueOrDefault(proberties.Colours.Rim,0))
  vehicle.set_vehicle_tire_smoke_color(xmlvehicle,valueOrDefault(proberties.Colours.tyreSmoke_R,0),valueOrDefault(proberties.Colours.tyreSmoke_G,0),valueOrDefault(proberties.Colours.tyreSmoke_B,0))
  vehicle.set_vehicle_livery(xmlvehicle,valueOrDefault(proberties.Livery,0))
  vehicle.set_vehicle_number_plate_index(xmlvehicle,valueOrDefault(proberties.NumberPlateIndex,0))
  vehicle.set_vehicle_number_plate_text(xmlvehicle,valueOrDefault(proberties.NumberPlateText,"ZeroMenu)"))
  vehicle.set_vehicle_window_tint(xmlvehicle,valueOrDefault(proberties.WindowTint,0))
  vehicle.set_vehicle_bulletproof_tires(xmlvehicle,valueOrDefault(proberties.BulletProofTyres,false))
  vehicle.set_vehicle_engine_on(xmlvehicle,valueOrDefault(proberties.EngineOn,true),true,true)
  vehicle.set_vehicle_engine_health(xmlvehicle,valueOrDefault(proberties.EngineHealth,1000))
  vehicle.set_vehicle_doors_locked_for_all_players(xmlvehicle,valueOrDefault(proberties.LockStatus,false))
  vehicle.set_vehicle_neon_light_enabled(xmlvehicle,0,valueOrDefault(proberties.Neons.Left,false))
  vehicle.set_vehicle_neon_light_enabled(xmlvehicle,1,valueOrDefault(proberties.Neons.Right,false))
  vehicle.set_vehicle_neon_light_enabled(xmlvehicle,2,valueOrDefault(proberties.Neons.Front,false))
  vehicle.set_vehicle_neon_light_enabled(xmlvehicle,3,valueOrDefault(proberties.Neons.Back,false))  
  for i,line in pairs(proberties.Mods) do
    if(line == 'false') then vehicle.set_vehicle_extra(xmlvehicle,tonumber(i:sub(2)),false) end
    if(line == 'true') then vehicle.set_vehicle_extra(xmlvehicle,tonumber(i:sub(2)),true) end    
  end  
      
  vehicle.set_vehicle_door_open(xmlvehicle,0,valueOrDefault(proberties.DoorsOpen.FrontLeftDoor,false),true)
  vehicle.set_vehicle_door_open(xmlvehicle,1,valueOrDefault(proberties.DoorsOpen.FrontRightDoor,false),true)
  vehicle.set_vehicle_door_open(xmlvehicle,2,valueOrDefault(proberties.DoorsOpen.FrontLeftDoor,false),true)
  vehicle.set_vehicle_door_open(xmlvehicle,3,valueOrDefault(proberties.DoorsOpen.FrontRightDoor,false),true)
  vehicle.set_vehicle_door_open(xmlvehicle,4,valueOrDefault(proberties.DoorsOpen.Hood,false),true)
  vehicle.set_vehicle_door_open(xmlvehicle,5,valueOrDefault(proberties.DoorsOpen.Trunk,false),true)
   
  if(proberties.TyresBursted.FrontLeft == 'false') then vehicle.set_vehicle_tire_burst(xmlvehicle,0,false,0) else vehicle.set_vehicle_tire_burst(xmlvehicle,0,true,1000) end
  if(proberties.TyresBursted.FrontRight == 'false') then vehicle.set_vehicle_tire_burst(xmlvehicle,1,false,0) else vehicle.set_vehicle_tire_burst(xmlvehicle,1,true,1000) end
  if(proberties.TyresBursted.BackLeft == 'false') then vehicle.set_vehicle_tire_burst(xmlvehicle,4,false,0) else vehicle.set_vehicle_tire_burst(xmlvehicle,4,true,1000) end
  if(proberties.TyresBursted.BackRight == 'false') then vehicle.set_vehicle_tire_burst(xmlvehicle,5,false,0) else vehicle.set_vehicle_tire_burst(xmlvehicle,5,true,1000) end
  if(proberties.TyresBursted._2 == 'false') then vehicle.set_vehicle_tire_burst(xmlvehicle,2,false,0) else vehicle.set_vehicle_tire_burst(xmlvehicle,2,true,1000) end
  if(proberties.TyresBursted._3 == 'false') then vehicle.set_vehicle_tire_burst(xmlvehicle,3,false,0) else vehicle.set_vehicle_tire_burst(xmlvehicle,3,true,1000) end
  if(proberties.TyresBursted._6 == 'false') then vehicle.set_vehicle_tire_burst(xmlvehicle,45,false,0) else vehicle.set_vehicle_tire_burst(xmlvehicle,45,true,1000) end
  if(proberties.TyresBursted._7 == 'false') then vehicle.set_vehicle_tire_burst(xmlvehicle,47,false,0) else vehicle.set_vehicle_tire_burst(xmlvehicle,47,true,1000) end
  
  entity.set_entity_visible(xmlvehicle,valueOrDefault(proberties.IsVisible,true))
  --entity.set_entity_gravity(xmlvehicle,proberties.HasGravity)
  entity.set_entity_god_mode(xmlvehicle,valueOrDefault(proberties.IsInvincible,true))  
end

function processAttachment(atta,handler) 
  local single = false
  if(atta == nil) then
    single = true
  elseif(#atta == 0) then
    single = true  
  end    
  if(single) then 
    if(atta.Type == '1') then 
      processPedAttachment(atta,handler)
    elseif(atta.Type == '2') then
      processVehicleAttachment(atta,handler)
    elseif(atta.Type == '3') then 
      processObjectAttachment(atta,handler)
    else
       menu.notify("Unknown Typ: " .. atta.Type,"ZeroMenu",5,140)
    end 
  else
    for i=1,#atta,1 do
      if(atta[i].Type == '1') then 
        processPedAttachment(atta[i],handler)
      elseif(atta[i].Type == '2') then
        processVehicleAttachment(atta[i],handler)
      elseif(atta[i].Type == '3') then 
        processObjectAttachment(atta[i],handler)
      else
        print("Unknown Typ-" .. i .. ": " .. atta[i].Type)
      end
    end
  end
end

function processObjectAttachment(attachment,handler)
  local parent = xmlList[attachment.Attachment.AttachedTo]
  local objectHash = tonumber(attachment.ModelHash:sub(3), 16)
  menu.notify("Process Attachment Object","ZeroMenu",5,140) 
  local xmlObject = nil
  while not streaming.has_model_loaded(objectHash) do
    streaming.request_model(objectHash)
    system.wait(0)
  end 
  if(streaming.is_model_a_world_object(objectHash)) then
       xmlObject = object.create_world_object(objectHash,player.get_player_coords(player.player_id()),true,true)
     else
       xmlObject = object.create_object(objectHash,player.get_player_coords(player.player_id()),true,true)
     end
    xmlList[attachment.InitialHandle] = xmlObject
    entity.freeze_entity(xmlObject,valueOrDefault(attachment.FrozenPos,false))
    entity.set_entity_no_collsion_entity(xmlObject,parent,false)
    entity.set_entity_no_collsion_entity(parent,xmlObject,false)
    entity.set_entity_collision(xmlObject,true, false, true)
    entity.set_entity_gravity(xmlObject,valueOrDefault(attachment.HasGravity,true))
    entity.set_entity_god_mode(xmlObject,valueOrDefault(attachment.IsInvincible,true))
    entity.set_entity_visible(xmlObject,valueOrDefault(attachment.IsVisible,false))
    
    --local rotation = v3(valueOrDefault(attachment.PositionRotation.Pitch,0),valueOrDefault(attachment.PositionRotation.Roll,0),valueOrDefault(attachment.PositionRotation.Yaw,0))
    local rotation = v3(valueOrDefault(attachment.Attachment.Pitch,0),valueOrDefault(attachment.Attachment.Roll,0),valueOrDefault(attachment.Attachment.Yaw,0))
    --entity.set_entity_rotation(xmlObject,rotation)
    --local offset = v3(valueOrDefault(attachment.Attachment.X,0),valueOrDefault(attachment.Attachment.Y,0),valueOrDefault(attachment.Attachment.Z,0))
    local offset = v3(valueOrDefault(attachment.Attachment.X,0),valueOrDefault(attachment.Attachment.Y,0),valueOrDefault(attachment.Attachment.Z,0))
    entity.attach_entity_to_entity(xmlObject,parent,valueOrDefault(attachment.Attachment.BoneIndex,0),offset,rotation,false,true,false,2,true)
    streaming.set_model_as_no_longer_needed(objectHash) 
end
function processPedAttachment(attachment,handler)
  local parent = xmlList[attachment.Attachment.AttachedTo]
  local pedHash = tonumber(attachment.ModelHash:sub(3), 16)
  local ped = nil
  while not streaming.has_model_loaded(pedHash) do
    streaming.request_model(pedHash )
    system.wait(0)
  end
  ped = ped.create_ped(-1,pedHash,player.get_player_coords(player.player_id()),player.get_player_armour(player.player_id()),true,false)
  --local v3 = player.get_player_coords(player.player_id())
  local rotation = v3(valueOrDefault(attachment.PositionRotation.X,0),valueOrDefault(attachment.PositionRotation.Y,0),valueOrDefault(attachment.PositionRotation.Z,0))
  local offset = v3(valueOrDefault(attachment.Attachment.X,0),valueOrDefault(attachment.Attachment.Y,0),valueOrDefault(attachment.Attachment.Z,0))
  entity.set_entity_collision(ped,true, false, true)
  entity.attach_entity_to_entity(ped,parent,valueOrDefault(attachment.Attachment.BoneIndex,0),offset,rotation,false,false,false,0,true)
end
function processVehicleAttachment(attachment,handler)
  local parent = xmlList[attachment.Attachment.AttachedTo]
  local vehicleHash = tonumber(attachment.ModelHash:sub(3), 16)
  local vehicle = nil
  while not streaming.has_model_loaded(vehicleHash) do
    streaming.request_model(vehicleHash )
    system.wait(0)
  end
  --local v3 = player.get_player_coords(player.player_id())
  vehicle = spawnRawVehicle(vehicleHash,player.get_player_coords(player.player_id()))
  
  entity.set_entity_collision(vehicle,true, false, true)
  streaming.set_model_as_no_longer_needed(vehicleHash)
  xmlList[handler.root.Vehicle.InitialHandle] = vehicle
  processXMLVehileProberties(vehicle,attachment.VehicleProperties)
  local rotation = v3(valueOrDefault(attachment.PositionRotation.X,0),valueOrDefault(attachment.PositionRotation.Y,0),valueOrDefault(attachment.PositionRotation.Z,0))
  local offset = v3(valueOrDefault(attachment.Attachment.X,0),valueOrDefault(attachment.Attachment.Y,0),valueOrDefault(attachment.Attachment.Z,0))
  entity.attach_entity_to_entity(vehicle,parent,valueOrDefault(attachment.Attachment.BoneIndex,0),offset,rotation,false,false,false,0,true)
end

function loadXMLFile(file)
  local xmlHandler = xmlhandler:new()
  local parser = xml2lua.parser(xmlHandler)
  local file = xml2lua.loadFile(file)
  parser:parse(file)  
  return xmlHandler
end

function valueOrDefault(value,default)
  if(value ~= nil) then
    return value
  end
  return default
end
