--   __  _         _      _       ___               _                _ 
--  / / (_)  __ _ | |__  | |_    / __\ ___   _ __  | |_  _ __  ___  | |
-- / /  | | / _` || '_ \ | __|  / /   / _ \ | '_ \ | __|| '__|/ _ \ | |
--/ /___| || (_| || | | || |_  / /___| (_) || | | || |_ | |  | (_) || |
--\____/|_| \__, ||_| |_| \__| \____/ \___/ |_| |_| \__||_|   \___/ |_|
--          |___/
                                                      
if _Version then          
    menu.notify("LightControl.lua Already Loaded", "", 2, notify_color2)
    return
end

LightControl = menu.add_feature("LightControl", "parent", 0).id
fuel_consumption = menu.add_feature("fuel Consumption", "parent", LightControl).id
Vehicles = menu.add_feature("Vehicle Options", "parent", LightControl).id
Lights = menu.add_feature("Light Options", "parent", LightControl).id
Policeoptions = menu.add_feature("Police Options", "parent", LightControl).id
TrafficStop = menu.add_feature("Traffic Stop", "parent", Policeoptions).id
Escorts = menu.add_feature("Escorts | Convoys", "parent", LightControl).id
Escortoptions = menu.add_feature("Options", "parent", Escorts).id
PTFXoptions = menu.add_feature("PTFX Options", "parent", Vehicles).id
_Settings = menu.add_feature("Settings | Autostart", "parent", LightControl).id

require("LightControl/data")
menu.notify("Welcome to Light Control ".._Version, "", 4, notify_color1)
require("LightControl/functions")
require("LightControl/Vehicles")
require("LightControl/Lights")
require("LightControl/Police")
require("LightControl/Convoys")



Path =os.getenv('APPDATA') .. "\\PopstarDevs\\2Take1Menu\\scripts\\LightControl\\settings.lua"
if (utils.file_exists(Path) == false) then
  file = io.open(Path, "w")
  file:write("require('LigtControl')Features={{Feature1,false},{Feature2,false,0},{Feature3,false},{Feature4,true,10.0},{Feature5,false},{Feature6,true},{Feature7,false},{Feature8,false,3},{Feature9,true,2},{Feature10,false},{Feature11,false},{Feature12,false},{Feature13,false},{Feature14,false},{Feature15,true}}Blue_Lights={{_light1,60},{_light2,140},{_light3,70},{_light4,100},{_light5,120},{_light6,130}}")
  menu.notify("Settings.lua Recreated", "Autostart", 4, notify_color2)	
  menu.notify("Please Restart LightControl.lua", "Autostart", 6, notify_color2)	
end

require("LightControl/settings")


--Autostart Settings
local Feature_names = {"cruise control","Stance","Remove Vehicles","Torque","Auto Engine","Auto Warninglights","Auto Parksounds","Ptfx Vehicle","Lights with Horn","Convoy Lights","Convoy Autorepair","Convoy Leading Veh","Convoy Marker","Convoy Autoclear","Convoy Flags","fuel Consumption","fuel license plate"}
local Feature_Autostart = {}
for i=1, #Feature_names do
    Feature_Autostart[i] = menu.add_feature(Feature_names[i], "toggle", _Settings, function(feat)
    if feat.on then Features[i][2] = true end
    if not feat.on then Features[i][2] = false end
    end)
end

for i=1, #Features do
   if (Features[i][2] == true) then 
     Feature_Autostart[i]:toggle()
   end
end
 

--Save Autostart Settings
menu.add_feature("Save current config", "action", _Settings, function(feat)
Path =os.getenv('APPDATA') .. "\\PopstarDevs\\2Take1Menu\\scripts\\LightControl\\settings.lua"
--WIP if file not excists
if not(utils.file_exists(Path)) then
  file = io.open(Path, "w")
  file:write("require('LigtControl')Features={{Feature1,false},{Feature2,false,0},{Feature3,false},{Feature4,true,10.0},{Feature5,false},{Feature6,true},{Feature7,false},{Feature8,false,3},{Feature9,true,2},{Feature10,false},{Feature11,false},{Feature12,false},{Feature13,false},{Feature14,false},{Feature15,true}}Blue_Lights={{_light1,60},{_light2,140},{_light3,70},{_light4,100},{_light5,120},{_light6,130}}")
  menu.notify("Settings.lua Recreated", "", 2, notify_color2)	
  menu.notify("Please Restart LightControl.lua", "", 4, notify_color2)
end

file = io.open(Path, "w")
file:write("require('LigtControl')\n")
file:write("Features = {\n")
  for i=1, #Features do
      file:write("{ Feature"..i..", ")
	  if (Features[i][3] == nil) then
         if (Features[i][2] == true) then
         file:write(tostring(true))
         else
         file:write(tostring(false))
         end	
      end
      if (Features[i][3] ~= nil) then
         if (Features[i][2] == true) then
         file:write(tostring(true)..", ")
	     file:write(tostring(Features[i][3]))
         else
         file:write(tostring(false)..", ")
	     file:write(tostring(Features[i][3]))
         end	
      end	
      if (i ~= #Features) then	
      file:write(" },\n")
      else
      file:write(" }\n")
      end
  end
  file:write("}\n")

  file:write("\n \n Blue_Lights = {\n")
  for i=1, #Blue_Lights do
    file:write("{ _light"..i..", ")
	file:write(tostring(Blue_Lights[i][2]))   
    if (i ~= #Features) then	
    file:write(" },\n")
    else
    file:write(" }\n")
    end
  end
file:write("}\n")

file:close()
menu.notify("Config Saved", "", 2, notify_color1)	
end)


--Enables All Selected Features
for i=1, #Features do
   if (Features[i][2] == true) then
   Features[i][1]:toggle()
   end
end
