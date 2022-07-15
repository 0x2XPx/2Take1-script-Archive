
--local http = require("ZeroMenu2\\ZeroMenuLib\\luasocket\\lua\\http")


local zModderMain

-- features
local god,visible,neteventlogger,positionchecker,timer,timerTP,controlchecker,iPchecker

-- integers
local hookID

-- LogFile
local debugFilePath = os.getenv("APPDATA") .. "\\PopstarDevs\\2Take1Menu\\NetEventLog.ini"
local vpipv4 = os.getenv("APPDATA") .. "\\PopstarDevs\\2Take1Menu\\scripts\\ZeroMenuLib\\data\\vpn-ipv4.txt"
local debugFile

-- Seconds to check players
local minCheckTime = 10
local minCheckTimeTP = 1
-- Distanced moved in minCheckTime, if greater = teleport
local distanceCheck = 500
-- Debug Mode ?
local debugSetting = false

-- list for all players containing lists
local playerList
local lastGC = 0

local vpnIPList

local checkedList

function createModderDetectionMenuEntry(parent,config)

	zModderMain = menu.add_feature("Zero's Modder Detection", "parent", parent.id, nil)

  config:saveIfNotExist("godCheck",false)    
  config:saveIfNotExist("visibleCheck",false)   
  config:saveIfNotExist("PositionCheck",false)  
  config:saveIfNotExist("RequestCheck",false)  
  config:saveIfNotExist("IpCheck",false)

	-- Main Features
	god	= menu.add_feature("Godmode check", "toggle", zModderMain.id, checkPlayersForGod)
	god.threaded = false
	
	if config:isFeatureEnabled("godCheck") then
    god.on = true
  end  
	
	visible	= menu.add_feature("Visible check", "toggle", zModderMain.id, checkInvisible)
	visible.threaded = false
	
	if config:isFeatureEnabled("visibleCheck") then
    visible.on = true
  end
	
  positionchecker = menu.add_feature("Position Checker", "toggle", zModderMain.id, logDistanceMovedPerSec)
  positionchecker.threaded = false
  
  if config:isFeatureEnabled("PositionCheck") then
    positionchecker.on = true
  end
  
  controlchecker = menu.add_feature("Request Control Checker", "toggle", zModderMain.id, checkRequestControl)
  controlchecker.threaded = false
  
  if config:isFeatureEnabled("RequestCheck") then
    controlchecker.on = true
  end
  
  iPchecker = menu.add_feature("IP Range Checker", "toggle", zModderMain.id, checkIP)
  iPchecker.threaded = true
  
  if config:isFeatureEnabled("IpCheck") then
    iPchecker.on = true
  end
  
	playerList = {}
	
	vpnIPList = loadVPNList()
	checkedList = {}
end

function loadVPNList()
  vpnlist = {}

 local file = io.open(vpipv4, "r");
 for line in file:lines() do
    vpnlist[line] = true;
 end
  return vpnlist;
end


local lastIPCheck = 0
function checkIP()
  if (os.time() - lastIPCheck) > 10 then
    for slot = 0, 31 do
      if player.get_player_scid(slot) ~= -1 and player.get_player_scid(slot) ~= 4294967295 then
        if checkedList[player.get_player_name(slot)] == nil then        
          local ip = player.get_player_ip(slot)
          
          local ipS = string.format("%i.%i.%i.%i", (ip >> 24) & 0xff, ((ip >> 16) & 0xff), ((ip >> 8) & 0xff), ip & 0xff)
         
          --local http = require("socket.http")
          print("requesting...")
          --local l = http.request("http://www.cs.princeton.edu/~diego/professional/luasocket")
          --local http = require("socket.http")
          
         
         --[[
          local ipBlockA = tonumber((ip >> 24) & 0xff);
          local ipBlockB = tonumber((ip >> 16) & 0xff);
          local ipBlockC = tonumber((ip >> 8) & 0xff);
          local ipBlockD = tonumber(ip & 0xff);
    
          --Check Private 10.0.0.0 till 10.255.255.255
          if(ipBlockA == 10) then
            ui.notify_above_map(player.get_player_name(slot) .. " has an invalid IP " .. ipS,"ZModder Detection",140)
          end
          --Check Private 172.16.0.0 till 172.31.255.255
          if(ipBlockA == 172 and (ipBlockB >= 16 and ipBlockB <= 31)) then
            ui.notify_above_map(player.get_player_name(slot) .. " has an invalid IP " .. ipS,"ZModder Detection",140)
          end
          --Check Private 192.168.0.0 till 192.168.255.255
          if(ipBlockA == 192 and ipBlockB == 168) then
            ui.notify_above_map(player.get_player_name(slot) .. " has an invalid IP " .. ipS,"ZModder Detection",140)
          end
          
          
          if vpnlist[ipS] ~= nil then
            ui.notify_above_map(player.get_player_name(slot) .. " uses a VPN","ZModder Detection",140)
          end        
          checkedList[player.get_player_name(slot)] = 1
          ]]--
      end        
    end
  end
    lastIPCheck = os.time()    
  end
  if iPchecker.on then    
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function checkInvisible()
  for slot = 0, 31 do
    if player.get_player_scid(slot) ~= -1 and player.get_player_scid(slot) ~= 4294967295 then
      updatePlayerInfos(slot)
      local perPlayerList = playerList[player.get_player_name(slot)]
      if not entity.is_entity_visible(player.get_player_ped(slot)) and perPlayerList['distanceMoved'] >  0 then
        ui.notify_above_map(player.get_player_name(slot) .. " is invisible ","ZModder Detection",140)
      end
    end
  end
    if visible.on then    
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function checkRequestControl()
  for slot = 0, 31 do
    if player.get_player_scid(slot) ~= -1 and player.get_player_scid(slot) ~= 4294967295 then
      updatePlayerInfos(slot)
      local perPlayerList = playerList[player.get_player_name(slot)]
      if perPlayerList['lastControlCheck'] ~= nil then
        if (os.time() - perPlayerList['lastControlCheck']) > 1 then
          if player.get_player_scid(slot) ~= -1 and player.get_player_scid(slot) ~= 4294967295 then
          ped = player.get_player_ped(slot)
            if not network.has_control_of_entity(ped) then
              network.request_control_of_entity(ped)  
            end 
            if not network.has_control_of_entity(ped) then
              ui.notify_above_map(player.get_player_name(slot) .. " blocked request  ","ZModder Detection",140)
            end
          end
        else
          perPlayerList['lastControlCheck'] = os.time()      
        end
      else
         perPlayerList['lastControlCheck'] = os.time()      
      end
    end    
  end
  if controlchecker.on then    
    return HANDLER_CONTINUE
  else
    return HANDLER_POP
  end
end

function checkPlayersForGod()
	for slot = 0, 31 do
		if player.get_player_scid(slot) ~= -1 and player.get_player_scid(slot) ~= 4294967295 then
			-- add a player if not inside
			updatePlayerInfos(slot)
			
			local perPlayerList = playerList[player.get_player_name(slot)]			
			if perPlayerList['totalGodTime'] >= minCheckTime then
				if perPlayerList['totalChecked'] >= minCheckTime then
					-- inside rc vehicle car?
					--if player.get_player_vehicle(slot) == 0 then
					-- if entity.is_entity_visible(player.get_player_ped(slot)) then
  					 ui.notify_above_map(player.get_player_name(slot) .. " is using god since " .. perPlayerList['totalGodTime'] .. " of " .. minCheckTime .. " seconds","ZModder Detection",140)
             player.set_player_as_modder(slot,1)
					 --end
						
					--end
				end
			end			
		end		
	end
	if god.on then		
		return HANDLER_CONTINUE
	else
		return HANDLER_POP
	end
end


function logDistanceMovedPerSec()	
	for slot = 0, 31 do
		if player.get_player_scid(slot) ~= -1 and player.get_player_scid(slot) ~= 4294967295 then
			-- add a player if not inside
			updatePlayerInfos(slot)		
			local perPlayerList = playerList[player.get_player_name(slot)]
			
			if  perPlayerList['distanceMoved'] >  500 and player.get_player_coords(slot).y > 0 then			
				ui.notify_above_map(player.get_player_name(slot) .. " moved " .. perPlayerList['distanceMoved'] .. " teleport?","ZModder Detection",140)
			end
		end		
	end
	if positionchecker.on then
		return HANDLER_CONTINUE
	else
		return HANDLER_POP
	end
end

-- This function is called by every subfeature
-- It updates the information stored about the players and resets them after > minCheckTime
function updatePlayerInfos(slot)
	if playerList[player.get_player_name(slot)] == nil then
		playerList[player.get_player_name(slot)] = {}
		playerList[player.get_player_name(slot)]['cords'] = player.get_player_coords(slot)
		playerList[player.get_player_name(slot)]['scid'] = player.get_player_scid(slot) 		
		playerList[player.get_player_name(slot)]['distanceMoved'] = 0
		playerList[player.get_player_name(slot)]['totalMoveCheck'] = 0
		playerList[player.get_player_name(slot)]['lastCheck'] = os.time() 
		playerList[player.get_player_name(slot)]['totalChecked'] = 0
		
		playerList[player.get_player_name(slot)]['gotTime'] = 0
		playerList[player.get_player_name(slot)]['totalGodTime'] = 0		
	end
	
	local perPlayerList = playerList[player.get_player_name(slot)]
	
	-- tped to a interior, reset distancemoved
	if isPlayerInside(slot) then			
		perPlayerList['distanceMoved'] = 0
	end
	
	-- Check the player for unnormal stuff
	if perPlayerList['totalChecked'] >= (minCheckTime+1) then		
		if perPlayerList['totalGodTime'] > 0 and perPlayerList['distanceMoved'] > 0 then
			debugPrint(player.get_player_name(slot) .. "'s godtime = " .. perPlayerList['totalGodTime'])
			debugPrint(player.get_player_name(slot) .. "'s distance moved = " .. perPlayerList['distanceMoved'])
			debugPrint(os.date("%X") .. " reset " .. player.get_player_name(slot))
		end		
		perPlayerList['totalChecked'] = 0
		perPlayerList['distanceMoved'] = 0
		perPlayerList['totalGodTime'] = 0
		perPlayerList['cords'] = player.get_player_coords(slot)
	end
	
	--Prüfe ojede Sekunde vergangen ist	
	if (os.time() - perPlayerList['lastCheck']) >= 1 then	
		--check for movement
		local oldCord = perPlayerList['cords']
		local newCord = player.get_player_coords(slot)				
		local distance = math.sqrt(math.pow(newCord['x'] - oldCord['x'],2) + math.pow(newCord['y'] - oldCord['y'],2) + math.pow(newCord['z'] - oldCord['z'],2))
				
		perPlayerList['distanceMoved'] = (perPlayerList['distanceMoved'] + distance)
		perPlayerList['cords'] = player.get_player_coords(slot)
		perPlayerList['lastCheck'] = os.time() 
		perPlayerList['totalChecked'] = (perPlayerList['totalChecked']+1)
		
		--check for godtime
		if player.is_player_god(slot) then
			if interior.get_interior_from_entity(player.get_player_ped(slot)) ~= nil and interior.get_interior_from_entity(player.get_player_ped(slot)) == 0 and not isPlayerInside(slot) then
				if perPlayerList['distanceMoved'] > 0 then
					perPlayerList['totalGodTime'] = (perPlayerList['totalGodTime']+1)
					--perPlayerList['distanceMoved'] = 0
				end				
			end
		end		
		--Clear disconnected Users every min
		if (os.time() - lastGC) >= 60 then	
			local tempPlayerList = {}
			
			for slot = 0, 31 do			
				-- Is the player stored?
				if playerList[player.get_player_name(slot)] ~= nil then
					tempPlayerList[player.get_player_name(slot)] = playerList[player.get_player_name(slot)]
				end
			end
			--delete references
			playerList = nil
			-- relink list
			playerList = tempPlayerList
			
			lastGC = os.time()
		end		
	end
end
function isPlayerInside(slot)
  local interior = script.get_global_i(2424073 + (slot * 421) + 235 + 1)
  --print(interior)
  return interior ~= 0
end
function debugPrint(message) 
  if debugSetting then
    print(message)
  end
end