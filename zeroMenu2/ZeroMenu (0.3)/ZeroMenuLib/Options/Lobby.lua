require("ZeroMenuLib/Util/Util")

local modders = {}
local modderFilePath = os.getenv("APPDATA") .. "\\PopstarDevs\\2Take1Menu\\scripts\\ZeroMenuLib\\data\\modders.csv"

local logModderOption,warnOfLoadedModdersOption

function createLobbyOptions(parent,config)
  if not utils.file_exists(modderFilePath) then
      local file = io.open(modderFilePath, "a")
      file:write("date,scid,name,reason,ip\n")
      file:close()
    end    
    loadModderFile()
    local LobbyParent = menu.add_feature("Lobby","parent",parent.id,nil)    
    --createConfigedMenuOption(name,type,parent,script_function,config,configValueName,defaultValue,defaultValueMax)
    logModderOption = createConfigedMenuOption("Log Modder","toggle",LobbyParent.id,logModders,config,"logModder",false,nil)    
    warnOfLoadedModdersOption = createConfigedMenuOption("Info about known Modders","toggle",LobbyParent.id,infoModders,config,"infoModder",false,nil)    

end

function logModders()
  for slot = 0, 31 do
    if player.is_player_valid(slot) then      
      if isPlayerModder(slot) and modders[player.get_player_name(slot)] == nil then
        storeModder(slot)     
      elseif modders[player.get_player_name(slot)] ~= nil and warnOfLoadedModdersOption.on then
        local modderData = modders[player.get_player_name(slot)]
        if modderData["notified"] == 0 then          
          ui.notify_above_map(player.get_player_name(slot) .. " is a known Modder for " .. player.get_modder_flag_text(modderData["reason"]) .. " (" .. modderData["date"] .. ")" ,"ZeroMenu",140)
          
          
          
          if string.match(tostring(player.get_player_scid(slot)),string.sub(tostring(modderData["scid"]),1)) == nil then
            ui.notify_above_map("Scid missmatch " .. player.get_player_name(slot) .. " had scid '" .. string.sub(tostring(modderData["scid"]),1) .. "' but now he has '" .. player.get_player_scid(slot) .. "'","ZeroMenu",140)
          end
          player.set_player_as_modder(slot,modderData["reason"])
          modderData["notified"] = 1
          modders[player.get_player_name(slot)] = modderData
        end
      end    
    end
  end
  if logModderOption.on then
      return HANDLER_CONTINUE
    else
      return HANDLER_POP
    end
end

function loadModderFile()
  if utils.file_exists(modderFilePath)then      
    for line in io.lines(modderFilePath) do         
      if not starts_with(line,'#') and not starts_with(line,'date,') then
        fields = {}
        local cnt = 0
        line:gsub("([^"..",".."]*)", function(c)
           fields[cnt] = c
           cnt = cnt+1
        end)
        
        local modderDataTable = {}
        modderDataTable["date"] = fields[0]
        modderDataTable["scid"] = fields[1]
        modderDataTable["name"] = fields[2]
        modderDataTable["reason"] = fields[3]
        modderDataTable["ip"] = fields[4]
        modderDataTable["notified"] = 0
        modders[fields[2]] = modderDataTable
        
        print("loaded modder " .. modderDataTable["name"])
        end     
      end    
    else
      return false
    end
end

function storeModder(slot)
  ui.notify_above_map("Storing " .. player.get_player_name(slot) .. " in Modder Database","ZeroMenu",140)
  local file = io.open(modderFilePath, "a")
  local ip = player.get_player_ip(slot)                 
  local ipS = formatIP(ip)   
  file:write(
    os.date("[%d/%m/%Y %H:%M:%S]") .. 
      ", " .. player.get_player_scid(slot) .. 
      "," .. player.get_player_name(slot) .. 
      "," .. player.get_player_modder_flags(slot) .. "," .. ipS .. "\n")
    file:close()  
    local modderDataTable = {}
    modderDataTable["date"] = os.date("[%d/%m/%Y %H:%M:%S]")
    modderDataTable["name"] = player.get_player_name(slot)
    modderDataTable["scid"] = player.get_player_scid(slot)
    modderDataTable["reason"] = player.get_player_modder_flags(slot)
    modderDataTable["ip"] = ipS
    modderDataTable["notified"] = 0
    modders[player.get_player_name(slot)] = modderDataTable
end