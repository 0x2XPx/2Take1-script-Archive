require("ZeroMenuLib/Options/modderDetection")
require("ZeroMenuLib/Options/Vehicles")
require("ZeroMenuLib/Options/Nearby")
require("ZeroMenuLib/Options/Self")
require("ZeroMenuLib/Options/Grief")
require("ZeroMenuLib/Options/Protection")
require("ZeroMenuLib/Options/ChatCommands")
require("ZeroMenuLib/Options/World")
require("ZeroMenuLib/Options/Lobby")
require("ZeroMenuLib/util/config")
require("ZeroMenuLib/enums/VehicleHash")
require("ZeroMenuLib/Options/VehicleBuilder")

local ignoreplayers
configpath = os.getenv('APPDATA') .. "\\PopstarDevs\\2Take1Menu\\scripts\\ZeroMenuLib\\data\\config.cfg"
configfolder = os.getenv('APPDATA') .. "\\PopstarDevs\\2Take1Menu\\scripts\\ZeroMenuLib\\data"

function zeroMenuMain()
  if not utils.dir_exists(configfolder) then
    utils.make_dir(configfolder)
  end
  config = Config:create(configpath,true)

-- Main Feature
  zeroMenu = menu.add_feature("ZeroMenu", "parent", 0, nil) 
  --load Vehicle Options
  loadVehicleMenu(zeroMenu,config)  
  --Load Modder Detection 
  createModderDetectionMenuEntry(zeroMenu,config)
  --Load Nearby
  createNearbyMenu(zeroMenu,config)
    
  createSelfMenuEntry(zeroMenu,config)
  
  createGriefEntry(config)
  
  createProtectionMenu(zeroMenu,config)
  
  createWorldMenu(zeroMenu,config)
  
  createChatCommands(zeroMenu,config)
  
  createLobbyOptions(zeroMenu,config)
  
  createVehicleBuilderEntry(zeroMenu,config)
  
  if(player.get_player_name(player.player_id()) == "1336Zero") then
    require("ZeroMenuLib/Options/Dev")
    createDevEntry(zeroMenu,config)
  end
      
  --load Settings
  loadSetting(zeroMenu,config)
  
  menu.notify("ZeroMenu v0.5 build-263 loaded!","ZeroMenu",5,140)  
end

function loadSetting(parent,config)
  settings = menu.add_feature("Settings", "parent",parent.id, nil)
  --Nearby Settings  
  loadNearbySettings(settings,config)
  loadVehicleSetting(settings,config)
  
  settings = menu.add_feature("Save", "action",settings.id, 
  function()
    config:saveConfig()
  menu.notify("saving config","ZeroMenu",5,140)  
  end)
end
zeroMenuMain()
