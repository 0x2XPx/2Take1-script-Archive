if not menu.is_trusted_mode_enabled(8) then
  menu.notify("Please turn on Trusted mode(Http)", "sG.wolf's script public version", 10, 1)
  return
end


local rootPath = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
--Chat spammer
local load_chat_preset_1 = io.open(rootPath.."\\scripts\\sG.wolf's_script\\chat_spam_preset\\chat_preset_1.txt", "r")
local load_chat_preset_2 = io.open(rootPath.."\\scripts\\sG.wolf's_script\\chat_spam_preset\\chat_preset_2.txt", "r")
local load_chat_preset_3 = io.open(rootPath.."\\scripts\\sG.wolf's_script\\chat_spam_preset\\chat_preset_3.txt", "r")
local load_chat_preset_4 = io.open(rootPath.."\\scripts\\sG.wolf's_script\\chat_spam_preset\\chat_preset_4.txt", "r")
local load_chat_preset_1_default = io.open(rootPath.."\\scripts\\sG.wolf's_script\\preset\\c_preset1.cfg", "r")
local load_chat_preset_2_default = io.open(rootPath.."\\scripts\\sG.wolf's_script\\preset\\c_preset2.cfg", "r")
local load_chat_preset_3_default = io.open(rootPath.."\\scripts\\sG.wolf's_script\\preset\\c_preset3.cfg", "r")
local load_chat_preset_4_default = io.open(rootPath.."\\scripts\\sG.wolf's_script\\preset\\c_preset4.cfg", "r")
local load_chat_preset_5_default = io.open(rootPath.."\\scripts\\sG.wolf's_script\\preset\\c_preset5.cfg", "r")
local load_chat_preset_6_default = io.open(rootPath.."\\scripts\\sG.wolf's_script\\preset\\c_preset6.cfg", "r")
local load_chat_preset_7_default = io.open(rootPath.."\\scripts\\sG.wolf's_script\\preset\\c_preset7.cfg", "r")
local chat_preset_1 = load_chat_preset_1:read("*a")
local chat_preset_2 = load_chat_preset_2:read("*a")
local chat_preset_3 = load_chat_preset_3:read("*a")
local chat_preset_4 = load_chat_preset_4:read("*a")
local chat_preset_1_default = load_chat_preset_1_default:read("*a")
local chat_preset_2_default = load_chat_preset_2_default:read("*a")
local chat_preset_3_default = load_chat_preset_3_default:read("*a")
local chat_preset_4_default = load_chat_preset_4_default:read("*a")
local chat_preset_5_default = load_chat_preset_5_default:read("*a")
local chat_preset_6_default = load_chat_preset_6_default:read("*a")
local chat_preset_7_default = load_chat_preset_7_default:read("*a")
load_chat_preset_1:close()
load_chat_preset_2:close()
load_chat_preset_3:close()
load_chat_preset_4:close()
load_chat_preset_1_default:close()
load_chat_preset_2_default:close()
load_chat_preset_3_default:close()
load_chat_preset_4_default:close()
load_chat_preset_5_default:close()
load_chat_preset_6_default:close()
load_chat_preset_7_default:close()
--chatbot
local chatbot = dofile(rootPath.."\\scripts\\sG.wolf's_script\\lib\\Chatbot.lua")

--Heist
-- local Casino_Preset_Folder = rootPath.."\\scripts\\sG.wolf's_script\\Heist_Manager\\Casino"
-- local Casino_Preset = {}
-- local Cayo_Preset_Folder = rootPath.."\\scripts\\sG.wolf's_script\\Heist_Manager\\Cayo"
-- local Cayo_Preset = {}

--Translate
local Translate_Folder = rootPath.."\\scripts\\sG.wolf's_script\\Translate"
local default_translate_file = io.open(Translate_Folder.."\\default.cfg", "r")
local default_translate = default_translate_file:read("*a")
default_translate_file:close()
local Translate = dofile(Translate_Folder.."\\"..default_translate)
local Translate_list = {}

--Custom Teleport
local Teleport_Preset_Folder = rootPath.."\\scripts\\sG.wolf's_script\\Teleport"
local Teleport_Preset = {}

--player log
local player_log = {}

--squid game
local player_coords = {}

--player list
local blame_feature = {}

--modder flag
local mark_all_modder_flag = player.add_modder_flag(Translate["Mark all as modder"])
local VPN_flag = player.add_modder_flag("Using VPN")

--vpn
local vpn_check_req_num_per_min = 0

--check if already loaded
if wolf_main_menu ~= nil then
    return
end

--http get function
local function http_get(url)
  local status, body = web.get(url)
  if status == 200 then
      return body
  else
    return "Error"
  end
end


--VPN check function
local function vpn_check(ip)
  ip = string.format("%i.%i.%i.%i", ip >> 24 & 0xff, ip >> 16 & 0xff, ip >> 8 & 0xff, ip & 0xff)
  local json = http_get("http://ip-api.com/json/"..ip.."?fields=status,message,proxy")
  --example of json
    --non-proxy
      -- {
      --   "status": "success",
      --   "proxy": false
      -- }
    --proxy
      -- {
      --   "status": "success",
      --   "proxy": true
      -- }
    --fail
      -- {
      --   "status": "fail"
      -- }
  if json:find("success") then
    if json:find("true") then
      return true
    else
      return false
    end
  else
    return "Error"
  end
end


--json to table function
local function json_to_table(json)
  local table = {}
  json = string.gsub(json, '""', '"Null"')
  for key, value in string.gmatch(json, '"([^"]+)":"([^,]+)"') do
    table[key] = value
  end
  
  for key, value in string.gmatch(json, '"([^"]+)":([^,]+)') do
    if table[key] == nil then
      table[key] = value
    end
  end

  return table
end


menu.notify(Translate["sG.wolf's script loading"], Translate["sG.wolf's script public version"], 1, 1)
menu.notify(Translate["Copyright(C)2021 sG.wolf all rights reserved."], Translate["sG.wolf's script public version"], 1, 1)

wolf_main_menu = menu.add_feature(Translate["sG.wolf script"], "parent", 0)
--self
local self = menu.add_feature(Translate["self"], "parent", wolf_main_menu.id)
  menu.add_feature(Translate["SOON"], "action", self.id, function (feat)
    
  end)

--weapon
local weapon = menu.add_feature(Translate["weapon"], "parent", wolf_main_menu.id)
    
  local function get_collision_vector(m, Ped)
    local me = player.get_player_coords(m)
    local pos, rot = me, cam.get_gameplay_cam_rot()
    rot:transformRotToDir()
    local pos = rot * 1000 + pos
    local n, Pos = worldprobe.raycast(me, pos, -1, Ped)
    local d = me - Pos
    return Pos, math.abs(d.x) + math.abs(d.y), pos
  end

  menu.add_feature(Translate["sight Airstrike"], "toggle", weapon.id, function(f)
    local we, Ped, pid = gameplay.get_hash_key("weapon_airstrike_rocket"), player.get_player_ped(player.player_id()), player.player_id()
    while f.on do
      local Pos, d = get_collision_vector(pid, Ped)
      if d > 3 then
        gameplay.shoot_single_bullet_between_coords(Pos, Pos, 1000, we, Ped, true, false, 250)
      end
      system.yield(0)
    end
  end)
  

  menu.add_feature(Translate["sight RailGun"], "toggle", weapon.id, function(f)
    local we, Ped, pid = gameplay.get_hash_key("WEAPON_RAILGUN"), player.get_player_ped(player.player_id()), player.player_id()
    while f.on do
      local Pos, d = get_collision_vector(pid, Ped)
      if d > 3 then
          gameplay.shoot_single_bullet_between_coords(Pos + v3(0, 0, 3), Pos, 1000, we, Ped, true, false, 250)
      end
      system.yield(0)
    end
  end)
  

      
  menu.add_feature(Translate["Airstrike Gun"], "toggle", weapon.id, function(f)
    local we, Ped, P = gameplay.get_hash_key("weapon_airstrike_rocket"), player.get_player_ped(player.player_id()), v3(0, 0, 10)
    while f.on do
      local m = player.player_id()
      if f.on and ped.is_ped_shooting(Ped) then
        local Pos, d = get_collision_vector(m, Ped)
        if d > 3 then
          gameplay.shoot_single_bullet_between_coords(Pos + P, Pos, 1000, we, Ped, true, false, 250)
        end
      end
      system.yield(0)
    end
  end)



--chat
local chat = menu.add_feature(Translate["chat"], "parent", wolf_main_menu.id)
--spam
  local chat_spammer = menu.add_feature(Translate["chat spammer"], "parent", chat.id)
    local default_chat_spammer = menu.add_feature(Translate["chat preset(default)"], "parent", chat_spammer.id)
      menu.add_feature(Translate["'Fuck you Chinese!' MassSpam"], "toggle", default_chat_spammer.id, function (feat)
        if feat.on then
          network.send_chat_message(chat_preset_1_default, false)
          system.wait(0)
          return HANDLER_CONTINUE
        end
        return HANDLER_POP
      end)
      menu.add_feature(Translate["'2TAKE1 GOD.' MassSpam"], "toggle", default_chat_spammer.id, function (feat)
        if feat.on then
          network.send_chat_message(chat_preset_2_default, false)
          system.wait(0)
          return HANDLER_CONTINUE
        end
        return HANDLER_POP
      end)
      menu.add_feature(Translate["'FUCK YOU!' MassSpam"], "toggle", default_chat_spammer.id, function (feat)
        if feat.on then
          network.send_chat_message(chat_preset_3_default, false)
          system.wait(0)
          return HANDLER_CONTINUE
        end
        return HANDLER_POP
      end)
      menu.add_feature(Translate["'LOVE ME!' MassSpam"], "toggle", default_chat_spammer.id, function (feat)
        if feat.on then
          network.send_chat_message(chat_preset_4_default, false)
          system.wait(0)
          return HANDLER_CONTINUE
        end
        return HANDLER_POP
      end)
      menu.add_feature(Translate["'FUCK YOU!' Spam"], "toggle", default_chat_spammer.id, function (feat)
        if feat.on then
          network.send_chat_message(chat_preset_5_default, false)
          system.wait(0)
          return HANDLER_CONTINUE
        end
        return HANDLER_POP
      end)
      menu.add_feature(Translate["'YOU SUCK' Spam"], "toggle", default_chat_spammer.id, function (feat)
        if feat.on then
          network.send_chat_message(chat_preset_6_default, false)
          system.wait(0)
          return HANDLER_CONTINUE
        end
        return HANDLER_POP
      end)
      menu.add_feature(Translate["'Fuck you Chinese!' Spam"], "toggle", default_chat_spammer.id, function (feat)
        if feat.on then
          network.send_chat_message(chat_preset_7_default, false)
          system.wait(0)
          return HANDLER_CONTINUE
        end
        return HANDLER_POP
      end)
      menu.add_feature(Translate["'Empty' Message Spam"], "toggle", default_chat_spammer.id, function (feat)
        if feat.on then
          network.send_chat_message(' ', false)
          system.wait(0)
          return HANDLER_CONTINUE
        end
        return HANDLER_POP
      end)
    
    menu.add_feature(Translate["custom chat spammer"], "toggle", chat_spammer.id, function(feat)
      local r, s = input.get(Translate["Enter Chat Message"], "", 100, 0)
      if r == 1 then
        return HANDLER_CONTINUE
      end
      if r == 2 then
          return HANDLER_POP
      end
      while feat.on do
        network.send_chat_message(s, false)
        system.wait(0)
      end
      return HANDLER_POP
    end)
    menu.add_feature(Translate["clipbord chat spammer"], "toggle", chat_spammer.id, function (feat)
      local clipbord = utils.from_clipboard()
      if feat.on then
        network.send_chat_message(clipbord, false)
        system.wait(0)
        return HANDLER_CONTINUE
      end
      return HANDLER_POP
    end)
    menu.add_feature(Translate["spam 'preset 1'"], "toggle", chat_spammer.id, function(feat)
      if feat.on then
        network.send_chat_message(chat_preset_1, false)
        system.wait(0)
        return HANDLER_CONTINUE
      end
      return HANDLER_POP
    end)
    menu.add_feature(Translate["spam 'preset 2'"], "toggle", chat_spammer.id, function(feat)
      if feat.on then
        network.send_chat_message(chat_preset_2, false)
        system.wait(0)
        return HANDLER_CONTINUE
      end
      return HANDLER_POP
    end)
    menu.add_feature(Translate["spam 'preset 3'"], "toggle", chat_spammer.id, function(feat)
      if feat.on then
        network.send_chat_message(chat_preset_3, false)
        system.wait(0)
        return HANDLER_CONTINUE
      end
      return HANDLER_POP
    end)
    menu.add_feature(Translate["spam 'preset 4'"], "toggle", chat_spammer.id, function(feat)
      if feat.on then
        network.send_chat_message(chat_preset_4, false)
        system.wait(0)
        return HANDLER_CONTINUE
      end
      return HANDLER_POP
    end)
  
  local chatbot_join, chatbot_chat
  menu.add_feature("Chatbot Action", "value_str", chat.id, function (feat)
    if feat.on then
      if chatbot_join == nil then
        chatbot_join = event.add_event_listener("player_join", function (i)
          for x = 1, #chatbot do
            if player.get_player_name(i.player) == chatbot[x] then
              if feat.value == 0 then
                network.network_session_kick_player(i.player)
                menu.notify(Translate["Kicked Chatbot:"] .. chatbot[x]) --Translate required
              else
                --action
              end
            end
          end
        end)
      end
      --[[
      if chatbot_chat == nil then
        chatbot_chat = event.add_event_listener("chat", function (i)
          if i.body
        end)
      end]]--
    end
    if not feat.on then
      event.remove_event_listener("player_join", chatbot_join)
    end
  end):set_str_data({"Kick"})

--protex
local protex = menu.add_feature(Translate["protex"], "parent", wolf_main_menu.id)
  local all_modder_on = false
  local all_modder = menu.add_feature(Translate["Mark all Players as Modder"], "toggle", protex.id, function(feat)
    if all_modder_on == false then
      local my_pid = player.player_id()
      for pid = 0, 32 do
        if pid ~= my_pid then
          player.set_player_as_modder(pid, mark_all_modder_flag)
        end
      end
      mapam = event.add_event_listener("player_join", function(i)
        player.set_player_as_modder(i.player, mark_all_modder_flag)
      end)
      all_modder_on = true
    end
    if feat.on == false then
      event.remove_event_listener("player_join", mapam)
      all_modder_on = false
    end
  end)

  menu.add_feature(Translate["Unmark all Players as Modder"], "action", protex.id, function()
    local my_pid = player.player_id()
    for pid = 0, 32 do
      if pid ~= my_pid then
        player.unset_player_as_modder(pid, -1)
      end
    end
    all_modder.on = false
  end)

  local safe_space = menu.add_feature(Translate["Safe Space(anti-crash-cam)"], "toggle", protex.id, function(feat)
    location = player.get_player_coords(player.player_id()) --save location
    menu.notify(Translate["Here is safe space!"], Translate["sG.wolf's script public ver"], 1, 190)
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-75, -818, 326)) --mazebank
    system.yield(10)
    while feat.on do
      entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(-8292.664, -4596.8257, 14358.0))--safe space
      system.yield(10000)
    end
    if feat.on == false then
      menu.notify(Translate["Wait a sec"], Translate["sG.wolf's script public ver"], 2, 190)
    end
    system.yield(10)
    entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), location)
  end)

  local aacc_on = false
  menu.add_feature(Translate["Frame Drop Protection"], "value_str", protex.id, function (feat)
    if feat.on then
      system.yield(1000)
      if math.floor(1/gameplay.get_frame_time()) <= 15 then
        if feat.value == 0 then
          if not aacc_on then
            menu.notify(Translate["Auto Anti-Crash Cam ACTIVATED!"], Translate["sG.wolf's script public ver"], 2, 190)
            menu.notify(Translate["If you want to turn off the anti-crash cam,\nplease turn it off manually"], Translate["sG.wolf's script public ver"], 8, 190)
            aacc_on = true
            safe_space.on = true
          end
        else
          network.force_remove_player(player.player_id())
          feat.on = false
        end
      end
      return HANDLER_CONTINUE
    end
    if feat.on == false then
      aacc_on = false
      return HANDLER_POP
    end
  end):set_str_data({"Anti-Crash Cam", "Net Bail"})

--teleport
local teleport = menu.add_feature(Translate["Teleport"], "parent", wolf_main_menu.id)
  menu.add_feature(Translate["auto teleport to Waypoint"], "toggle", teleport.id, function (feat)
    if feat.on then
      if ui.get_waypoint_coord() ~= v2(16000.0, 16000.0) then
        local pos, bool = v3(ui.get_waypoint_coord().x, ui.get_waypoint_coord().y, 100)
        bool, pos.z = gameplay.get_ground_z(pos)
        pos.z = pos.z + 1
        if bool == false then
          pos.z = pos.z + 200
          menu.notify(Translate["I can't get the coordinates of the ground :(("], Translate["sG.wolf's script public ver"], 2, 10)
          menu.notify(Translate["I'll teleport to the sky :)"], Translate["sG.wolf's script public ver"], 2, 10)
        end
        entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos)
        menu.notify(Translate["Teleported"], Translate["sG.wolf's script public ver"], 1, 10)
        system.wait(10)
        if bool == false then
          ai.task_parachute(player.get_player_ped(player.player_id()), true, false)
        end
      end
      return HANDLER_CONTINUE
    end
    return HANDLER_POP
  end)

  menu.add_feature(Translate["Random Pos Teleport"], "action", teleport.id, function(feat)
      local pos, bool = v3(math.random(-2000, 1300), math.random(-3351, 6500), 100)
      bool, pos.z = gameplay.get_ground_z(pos)
      pos.z = pos.z + 1
      if bool == false then
        pos.z = pos.z + 200
        menu.notify(Translate["I can't get the coordinates of the ground :(("], Translate["sG.wolf's script public ver"], 2, 10)
        menu.notify(Translate["I'll teleport to the sky :)"], Translate["sG.wolf's script public ver"], 2, 10)
      end
      entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos)
      menu.notify(Translate["Teleported"], Translate["sG.wolf's script public ver"], 1, 10)
      system.wait(10)
      if bool == false then
        ai.task_parachute(player.get_player_ped(player.player_id()), true, false)
      end
  end)

  local Custom_Teleport = menu.add_feature(Translate["Custom Teleport"], "parent", teleport.id)
    local function load_custom_teleport()
      for i = 1, 100 do
        local a = utils.file_exists(Teleport_Preset_Folder.."\\"..i..".lua")
        if a then
          local Tele = dofile(Teleport_Preset_Folder.."\\"..i..".lua")
          menu.add_feature(Tele.name, "action_value_str", Custom_Teleport.id, function(feat)
            if feat.value == 0 then
              entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), Tele.pos)
              menu.notify(Translate["Teleported"], Translate["sG.wolf's script public ver"], 1, 10)
            end
            if feat.value == 1 then
              io.remove(Teleport_Preset_Folder.."\\"..i..".lua")
              menu.delete_feature(feat.id)
              menu.notify(Translate["Removed\nPlease Reload Custom Teleport Location"], Translate["sG.wolf's script public ver"], 1, 10)
            end
          end):set_str_data({Translate["Teleport"], Translate["Remove"]})
        end
      end
    end

    menu.add_feature(Translate["Add Custom Teleport Location(Current Location)"], "action", Custom_Teleport.id, function()
      local pos = player.get_player_coords(player.player_id())
      for i = 1, 100 do
        local a = utils.file_exists(Teleport_Preset_Folder.."\\"..i..".lua")
        if not a then
          local r, name = input.get(Translate["Enter Preset Name"], "", 100, 0)
          if r == 1 then
            return HANDLER_CONTINUE
          end
          if r == 2 then
            return HANDLER_POP
          end
          local file = io.open(Teleport_Preset_Folder.."\\"..i..".lua", "w")
          file:write([[
local Tele = {}
Tele.name = "]]..name..[["
Tele.pos = ]]..tostring(pos)..[[;
return Tele]])
          file:close()
          menu.notify(Translate["done"], Translate["sG.wolf's script public ver"], 1, 10)
          break
        end
        if i == 100 then
          menu.notify(Translate["The maximum number of presets is 100.\nPlease delete some presets and try again"], Translate["sG.wolf's script public ver"], 1, 10)
        end
      end
    end)

    menu.add_feature(Translate["[Developing]Add Custom Teleport Location(Input Location)"], "action", Custom_Teleport.id, function()
      --[[
      local pos = v3()
      for i = 1, 100 do
        local a = utils.file_exists(Teleport_Preset_Folder.."\\"..i..".lua")
        if not a then
          --name
          local r, name = input.get("Enter Preset Name", "", 100, 0)
          if r == 1 then
            return HANDLER_CONTINUE
          end
          if r == 2 then
            return HANDLER_POP
          end
          --pos(x)
          local r1, X = input.get("Enter X coord", "", 100, 5)
          if r1 == 1 then
            return HANDLER_CONTINUE
          end
          if r1 == 2 then
            return HANDLER_POP
          end
          pos.x = X
          --pos(y)
          local r2, Y = input.get("Enter Y coord", "", 100, 5)
          if r2 == 1 then
            return HANDLER_CONTINUE
          end
          if r2 == 2 then
            return HANDLER_POP
          end
          pos.y = Y
          --pos(z)
          local r3, Z = input.get("Enter Z coord", "", 100, 5)
          if r3 == 1 then
            return HANDLER_CONTINUE
          end
          if r3 == 2 then
            return HANDLER_POP
          end
          pos.z = Z

          local file = io.open(rootPath.."\\scripts\\File_test_lib\\"..i..".lua", "w") ]]--
--          file:write([[
--local Tele = {}
--Tele.name = "]]..name..[["
--Tele.pos = ]]..pos..[[;
--return Tele]])
--[[          file:close()
          menu.notify("done", "sG.wolf's script public ver", 1, 10)
          break
        end
        if i == 100 then
          menu.notify("The maximum number of presets is 100.\nPlease delete some presets and try again", "sG.wolf's script public ver", 1, 10)
        end
      end]]--
    end)

    menu.add_feature(Translate["Reload Custom Teleport Location"], "action", Custom_Teleport.id, function()
      print(#Teleport_Preset)
      print(#Custom_Teleport.children)
      for i = 4, #Custom_Teleport.children do
        if Custom_Teleport.children[4].id ~= nil then
          menu.delete_feature(Custom_Teleport.children[4].id)
        end
      end
      load_custom_teleport()
      menu.notify(Translate["Reload Done"], Translate["sG.wolf's script public ver"], 1, 10)
    end)

    load_custom_teleport()



--vehicle

local vehicle_o = menu.add_feature(Translate["vehicle"], "parent", wolf_main_menu.id)
  menu.add_feature(Translate["Vehicle missale rapid fire"], "value_str", vehicle_o.id, function (feat)
    if feat.on then
      if feat.value == 0 then
        if ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id())) then
          vehicle.set_vehicle_fixed(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())))
          system.wait(0)
        end
      end
      if feat.value == 1 then
        if ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id())) then
          vehicle.set_vehicle_fixed(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())))
          system.wait(50)
        end
      end
      if feat.value == 2 then
        if ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id())) then
          vehicle.set_vehicle_fixed(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())))
          system.wait(100)
        end
      end
      return HANDLER_CONTINUE
    end
    return HANDLER_POP
  end): set_str_data{Translate["Fast"], Translate["Normal"], Translate["Slow"]}

--SCID
local scid = menu.add_feature(Translate["SCID"], "parent", wolf_main_menu.id)
--[[
  --SCID Finder
  menu.add_feature(Translate["SCID Finder"], "action", scid.id, function()
    local r, name = input.get(Translate["Enter Username"], "", 100, 0)
    if r == 1 then
      return HANDLER_CONTINUE
    end
    if r == 2 then
      return HANDLER_POP
    end
    local SCID = http.request("GET", "https://eintim.one/", "ridapi.php?username="..name.."/")
    if SCID == "User not found." then
      menu.notify(Translate["I can't find SCID"], Translate["sG.wolf's script public ver"], 1, 0x9210a19a)
      menu.notify(Translate["Reason: \nInvalid Username or Server Error(https://eintim.one/ridapi.php)"], Translate["sG.wolf's script public ver"], 1, 0x9210a19a)
    else
      menu.notify("SCID : "..SCID, Translate["sG.wolf's script public ver"], 1, 0x530843e2)
      utils.to_clipboard(tostring(SCID))
      menu.notify(Translate["SCID copied!"], Translate["sG.wolf's script public ver"], 1, 0x530843e2)
    end
  end)
]]--

  menu.add_feature(Translate["SAVE SCID(RID)[TXT file]"], "action", scid.id, function()
    local scid_file = io.open(rootPath.."\\scripts\\sG.wolf's_script\\scid.txt", "a")
    scid_file:write(Translate["start saving scid\n\n"])
    menu.notify(Translate["start saving scid"], Translate["sG.wolf's script public ver"], 1, 10)
    for i = 0, 32 do
      local me = player.player_id()
        if i ~= me then
          local scids = player.get_player_scid(i)
          local username = player.get_player_name(i)
          if scids ~= nil then
            if username ~= nil then
            scid_file:write(username, ":", scids, "\n")
            end
          end
        end
    end
    scid_file:write(Translate["\nended saving scid\n\n\n"])
    scid_file:close()
    menu.notify(Translate["scid save ended"], Translate["sG.wolf's script public ver"], 1, 10)
    menu.notify(Translate["2take1 appdata - scripts - sG.wolf's_script - scid.txt"], Translate["sG.wolf's script public ver"], 2, 10)
  end)
  
  menu.add_feature(Translate["SAVE SCID(RID)[Hex][TXT file]"], "action", scid.id, function()
    local scid_file = io.open(rootPath.."\\scripts\\sG.wolf's_script\\scid.txt", "a")
    scid_file:write(Translate["start saving scid(hex)\n\n"])
    menu.notify(Translate["start saving scid(hex)"], Translate["sG.wolf's script public ver"], 1, 10)
    for i = 0, 32 do
      local me = player.player_id()
        if i ~= me then
          local scid_hex = string.format("%x", player.get_player_scid(i))
          local username = player.get_player_name(i)
          if scid_hex ~= nil then
            if username ~= nil then
              scid_file:write(username, ":", scid_hex, "\n")
            end
          end
        end
      end
      scid_file:write(Translate["\nended saving scid(hex)\n\n\n"])
      scid_file:close()
      menu.notify(Translate["scid save ended(hex)"], Translate["sG.wolf's script public ver"], 1, 10)
      menu.notify(Translate["2take1 appdata - scripts - sG.wolf's_script - scid.txt"], Translate["sG.wolf's script public ver"], 2, 10)
  end)

  menu.add_feature(Translate["Add as fakefriends(all session player)"], "action", scid.id, function()
    local fake_friends = io.open(rootPath.."\\cfg\\scid.cfg", "a")
    local read_fake_friends = io.open(rootPath.."\\cfg\\scid.cfg", "r")
    menu.notify(Translate["start add all players as fakefriends"], Translate["sG.wolf's script public ver"], 1, 10)
    for i = 0, 32 do
      local me = player.player_id()
        if i ~= me then
          local scid_hex = string.format("%x", player.get_player_scid(i))
          local username = player.get_player_name(i)
          local fake_friends_list = read_fake_friends:read("*a")
          if scid_hex ~= nil then
            if username ~= nil then
              if string.find(fake_friends_list, tostring(scid_hex)) == nil then
                fake_friends:write(username, ":", scid_hex, " \n")
                --print(username, ":", scid_hex,"saved")
              end
            end
          end
        end
    end
    fake_friends:close()
    menu.notify(Translate["add as fakefriends ended"], Translate["sG.wolf's script public ver"], 1, 10)
    menu.notify(Translate["please re-inject menu"], Translate["sG.wolf's script public ver"], 2, 10)
  end)
--[[
--Heist
local reload_hm

local Heist_main = menu.add_feature(Translate["Heist Manager"], "parent", wolf_main_menu.id)
  if menu.is_trusted_mode_enabled() then
    dofile(rootPath.."\\scripts\\sG.wolf's_script\\lib\\Heist.lua")
  else
    reload_hm = menu.add_feature(Translate["Reload 'Heist Manager'"], "action", Heist_main.id, function(feat)
      if menu.is_trusted_mode_enabled() then
        dofile(rootPath.."\\scripts\\sG.wolf's_script\\lib\\Heist.lua")
        menu.notify(Translate["Heist Manager loaded successfully"], Translate["sG.wolf's script public ver"], 1, 10) --translate add
        menu.delete_feature(reload_hm.id)
      else
        menu.notify(Translate["Heist Manger requires Trusted Mode to be activated"], Translate["sG.wolf's script public ver"], 1, 0x9210a19a)
      end
    end)
  end
]]--
--Misc
local Misc = menu.add_feature(Translate["Misc"], "parent", wolf_main_menu.id)

  local player_log_o = menu.add_feature(Translate["Player log[WIP]"], "parent", Misc.id)
    event.add_event_listener("player_join", function(pid)
      if pid.player == player.player_id() then
        return
      end
      local scid = player.get_player_scid(pid.player)
      player_log[#player_log + 1] = menu.add_feature(player.get_player_name(pid.player), "parent", player_log_o.id)
        menu.add_feature(Translate["copy SCID"], "action_value_str", player_log[#player_log].id, function(feat)
          if feat.on then
            if feat.value == 0 then
              utils.to_clipboard(tostring(scid))
            end
            if feat.value == 1 then
              utils.to_clipboard(string.format("%x", scid))
            end
          end
        end): set_str_data{Translate["int"], Translate["hex"]}
    end)
  
  local redlight = false
  local squid_join, squid_leave
  local squid = menu.add_feature(Translate["Squid Game"], "parent", Misc.id)
    menu.add_feature(Translate["Red Light, Green Light"], "value_str", squid.id, function(feat)
      if feat.on then
        if feat.value == 0 then
          if not redlight then
            for i = 1, 10 do
              network.send_chat_message(Translate["Red Light! DON'T MOVE!!!"], false)
              system.yield(50)
            end
            system.yield(2000)
            for pids = 1, player.player_count() do 
              player_coords[pids] = player.get_player_coords(pids)
            end
            print("Player_coords:"..#player_coords)
            squid_join = event.add_event_listener("player_join", function(i)
              menu.notify(Translate["New player joined.\n The player will join the game at the next Red Light"], Translate["sG.wolf's script public ver"], 3, 10)
            end)
            squid_leave = event.add_event_listener("player_leave", function(i)
              table.remove(player_coords, i.player)
              print("leave event Player_coords:"..#player_coords)
            end)
            redlight = true
            menu.notify(Translate["Red Light"], Translate["sG.wolf's script public ver"], 3 ,10)
          end
          system.yield(3000)
          for i = 1, #player_coords do
            if player_coords[i] ~= player.get_player_coords(i) and i ~= player.player_id() then
              for x = 1, 30 do
                fire.add_explosion(player.get_player_coords(i), 0, true, true, 0.0, player.get_player_ped(i))
                system.yield(10)
                if entity.is_entity_dead(player.get_player_ped(i)) then
                  break
                end
                if x == 30 then
                  if player.get_player_name(i) ~= nil then
                    menu.notify(Translate["I can't kill "]..player.get_player_name(i), Translate["sG.wolf's script public ver"], 3 ,10)
                  end
                end
              end
            end
          end
          return HANDLER_CONTINUE
        else --feat.value == 1
          if redlight then
            for i = 1, 10 do
              network.send_chat_message(Translate["Green Light! Now you can move."], false)
              system.yield(5)
            end
            player_coords = {}
            if squid_join ~= nil and squid_leave ~= nil then
              event.remove_event_listener("player_join", squid_join)
              event.remove_event_listener("player_leave", squid_leave)
            end
            redlight = false
            menu.notify(Translate["Green Light"], Translate["sG.wolf's script public ver"], 3 ,10)
          end
        end
      end
      if feat.on == false then
        if squid_join ~= nil and squid_leave ~= nil then
          event.remove_event_listener("player_join", squid_join)
          event.remove_event_listener("player_leave", squid_leave)
        end
        return HANDLER_POP
      end
    end):set_str_data{Translate["Red"], Translate["Green"]}

    --[[
    menu.add_feature("ped Kill aura(beta)", "value_f", Misc.id, function (feat) --Translate required
      if feat.on then
        local peds = ped.get_all_peds()
        system.yield(50)
        local player_coords = player.get_player_coords(player.player_id())
        for i = 0, #peds do
          local ped_ = peds[i]
          print(ped_)
          if not ped.is_ped_a_player(ped_)then
            local ped_coords = entity.get_entity_coords(ped_)
            if math.abs(player_coords.x - ped_coords.x) < feat.value and math.abs(player_coords.y - ped_coords.y) < feat.value and math.abs(player_coords.z - ped_coords.z) < feat.value then
              gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(ped_)+v3(0, 0, 65), entity.get_entity_coords(ped_) + v3(0, 0, 1), 10000.00, 0x6D544C99, 0, true, false, 10000.0)
            end
            system.yield(10)
          end
        end
        system.yield(100)
        return HANDLER_CONTINUE
      end
      if not feat.on then
        return HANDLER_POP
      end
    end).min = 0

    menu.add_feature("Player Kill aura(beta)", "value_f", Misc.id, function (feat) --Translate required
      if feat.on then
        local peds = ped.get_all_peds()
        local player_coords = player.get_player_coords(player.player_id())
        for i = 0, #peds do
          local ped_ = peds[i]
          if ped_ ~= player.get_player_ped() then
            local ped_coords = entity.get_entity_coords(ped_)
            if math.abs(player_coords.x - ped_coords.x) < feat.value and math.abs(player_coords.y - ped_coords.y) < feat.value and math.abs(player_coords.z - ped_coords.z) < feat.value then
              if ped.is_ped_a_player(ped_)then
                gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(ped_)+v3(0, 0, 65), entity.get_entity_coords(ped_) + v3(0, 0, 1), 10000.00, 0x6D544C99, 0, true, false, 10000.0)
              end
            end
            system.yield(10)
          end
        end
        system.yield(100)
        return HANDLER_CONTINUE
      end
      if not feat.on then
        return HANDLER_POP
      end
    end).min = 0
    ]]--


    menu.add_feature("Sync in-game time with real-time", "toggle", Misc.id, function(feat) --translate req
      if feat.on then
        local time_ = utils.time()
        local hour, minute, second = tonumber(os.date("%H", time_)), tonumber(os.date("%M", time_)), tonumber(os.date("%S", time_))
        time.set_clock_time(hour, minute, second)
        return HANDLER_CONTINUE
      end
      if not feat.on then
        return HANDLER_POP
      end
    end)

    local vpn_event
    local detect_vpn_feat = menu.add_feature("Detect VPN", "value_str", Misc.id, function (feat)
      if feat.on then
      
        local second = 0
      
        vpn_event = event.add_event_listener("player_join", function (p)
          local time_ = utils.time()
          system.yield(1000)
          if second == tonumber(os.date("%S", time_)) then
            vpn_check_req_num_per_min = 0
          end
          if vpn_check_req_num_per_min >= 45 then
            menu.notify("limited!(45req/min)", "VPN check", 5, 10)
          else
            local result = vpn_check(player.get_player_ip(p.player))
            if result == "Error" then
              menu.notify("fail to Detect VPN(Server Error)", "VPN check", 5, 10)
            elseif result then
              menu.notify(player.get_player_name(p.player).." is using VPN.", "VPN check", 5, 10)
              if feat.value == 1 then
                player.set_player_as_modder(p.player, VPN_flag)
              end
            end
          end
        end)
      
      end
  
      if not feat.on then
        event.remove_event_listener("player_join", vpn_event)
      end
    
    end)
    detect_vpn_feat:set_str_data({"notify", "Mark as modder"})

    --[[
    local info_overay = menu.add_feature("Info Overay", "parent", Misc.id)
      --on/off
      --setting
       --x/y position
       --size
       --now host on/off
       --next host on/off
       --now sh on/off
       --save now setting
      
      local info_text, info_position, info_text_size = "", v2(0, 0), v2(0, 0)
      local screen_w, screen_h = graphics.get_screen_width(), graphics.get_screen_height()

      local function get_next_host()
        for i = 0, 32 do
          if player.get_player_host_priority(i) == 1 then
            return i
          end
        end
      end

      menu.add_feature("toggle Info Overay", "toggle", info_overay.id, function (feat)
        if feat.on then
          d3d.draw_text(info_text)
        end
      end)

      local info_ov_text = menu.add_feature("set Info Overay text", "parent", info_overay.id)
        menu.add_feature("now Host", "toggle", info_ov_text.id, function (feat)
          if feat.on then
            info_text = info_text.."now Host : "..player.get_player_name(player.get_host()).."\n"
          end
        end)
        menu.add_feature("next Host", "toggle", info_ov_text.id, function (feat)
          if feat.on then
            info_text = info_text.."next Host : "..player.get_player_name(get_next_host()).."\n"
          end
        end)

      local info_pos = menu.add_feature("set Info Overay position", "parent", info_overay.id)
        --x
        local x = menu.add_feature("set Info Overay x", "value_f", info_pos.id, function (feat)
          info_position.x = feat.value
        end)
        x.min = 0
        x.max = screen_w
        --y
        local y = menu.add_feature("set Info Overay y", "value_f", info_pos.id, function (feat)
          info_position.y = feat.value
        end)
        y.min = 0
        y.max = screen_h
    
      menu.add_feature("set Info Overay size", "value_f", info_overay.id, function (feat)
        info_text_size.x = feat.value
        info_text_size.y = feat.value
      end)
]]
  local log_modder_event
  menu.add_feature("log modder", "toggle", Misc.id, function (feat)
    if feat.on then
      if log_modder_event == nil then  
        log_modder_event = event.add_event_listener("modder", function(event)
          local pid = event.player
          local modder_log_file = io.open(rootPath.."\\scripts\\sG.wolf's_script\\modder_log.txt", "a")
          local nick, scid, flag = player.get_player_name(pid), player.get_player_scid(pid), player.get_player_modder_flags(pid)
          flag = player.get_modder_flag_text(event.flag)
          modder_log_file:write(nick..":"..scid..", flag: "..flag.."\n")
          modder_log_file:close()
        end)
      end
    end
    if not feat.on then
      event.remove_event_listener(log_modder_event)
    end
  end)


  --Translation
  local Translate_o = menu.add_feature(Translate["Translation"], "parent", wolf_main_menu.id)
    local Trans_file = utils.get_all_files_in_directory(Translate_Folder, "lua")
    for i = 1, #Trans_file do
      menu.add_feature(string.sub(Trans_file[i], 0, (string.len(Trans_file[i]) - 4)), "action", Translate_o.id, function(feat)
        local default_trans = io.open(Translate_Folder.."\\default.cfg", "w+")
        default_trans:write(Trans_file[i])
        default_trans:close()
        menu.notify(Translate["Please Reload This Script"], Translate["sG.wolf's script public ver"], 10, 5)
      end)
    end


  --player options

wolf_player_main_menu = menu.add_player_feature(Translate["sG.wolf script"], "parent", 0)

  --private
  if utils.dir_exists(rootPath.."\\scripts\\sG.wolf's_script\\lib\\private") then
    if menu.is_trusted_mode_enabled(1) then
      dofile(rootPath.."\\scripts\\sG.wolf's_script\\lib\\private\\private_recovery.lua")
      menu.notify("private recovery loaded successfully", Translate["sG.wolf's script public ver"], 1, 10)
    end
    dofile(rootPath.."\\scripts\\sG.wolf's_script\\lib\\private\\crash.lua")
  end

--trolling
local trolling = menu.add_player_feature(Translate["Trolling"], "parent", wolf_player_main_menu.id)
  menu.add_player_feature(Translate["Railgun kill loop"], "toggle", trolling.id, function(feat, pid)
    while feat.on do
      system.wait(0)
      local pos = v3()
      pos = player.get_player_coords(pid)
      pos.z = pos.z + 65.0
      gameplay.shoot_single_bullet_between_coords(pos, player.get_player_coords(pid) + v3(0, 0, 1), 10000.00, 0x6D544C99, 0, true, false, 10000.0)
    end
  end)

  menu.add_player_feature(Translate["player lock-on(local ped)"], "action", trolling.id, function(feat, pid)
    streaming.request_model(0x15F8700D)
    local lock_on = ped.create_ped(2, 0x15F8700D, player.get_player_coords(pid), 0, false, false)
    entity.attach_entity_to_entity(lock_on, player.get_player_ped(pid), 0, v3(0, 0, 0), v3(0, 0, 0), true, false, false, 0, true)
  end)

  menu.add_player_feature("Kamikaze", "action", trolling.id, function (feat, pid) --translate req
    streaming.request_model(0x6CBD1D6D)
    if not streaming.has_model_loaded(0x6CBD1D6D) then
      system.wait()
    end
    
    player.send_player_sms(pid, "<font size='12'>~r~Tenno heika banzai!!!!!")
    system.yield(1000)
    player.send_player_sms(pid, "<font size='12'>~r~Tenno heika banzai!!!!!")
    
    --veh kick
    ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
    entity.freeze_entity(player.get_player_ped(pid), true)
    entity.freeze_entity(player.get_player_ped(pid), false)

    local veh = vehicle.create_vehicle(0x6CBD1D6D, player.get_player_coords(pid)+v3(0, 0, 50), 0, true, false)
    entity.set_entity_rotation(veh, v3(-90, 0, 0))

    vehicle.set_vehicle_forward_speed(veh, 60.0)

    system.yield(580)
    
    fire.add_explosion(entity.get_entity_coords(veh), 0, false, true, 0.0, player.get_player_ped(pid))
    streaming.set_model_as_no_longer_needed(0x6CBD1D6D)
  end)
--[[
  local blame = menu.add_player_feature(Translate["Blame"], "parent", trolling.id)

    event.add_event_listener("player_join", function(i)
      blame_feature[i.player] = menu.add_player_feature(player.get_player_name(i.player), "action", blame.id, function (feat, pid)
        
      end)
    end)
    event.add_event_listener("player_leave", function(i)
      table.remove(blame_feature, i.player)
    end)
]]--
menu.add_player_feature(Translate["set Waypoint"], "toggle", wolf_player_main_menu.id, function(feat, pid)
  if feat.on then
    local pos = player.get_player_coords(pid)
    ui.set_new_waypoint(v2(pos.x, pos.y))
    system.yield(800)
    return HANDLER_CONTINUE
  end
  if feat.on == false then
    local pos = player.get_player_coords(player.player_id())
    ui.set_new_waypoint(v2(pos.x, pos.y))
    return HANDLER_POP
  end
end)

menu.add_player_feature("check VPN", "action", wolf_player_main_menu.id, function(feat, pid)
  local time_ = utils.time()
  system.yield(1000)
  if second == tonumber(os.date("%S", time_)) then
    vpn_check_req_num_per_min = 0
  end
  if vpn_check_req_num_per_min >= 45 then
    menu.notify("limited!(45req/min)", "VPN check", 5, 10)
  else
    local result = vpn_check(player.get_player_ip(pid))
    if result == "Error" then
      menu.notify("fail to Detect VPN(Server Error)", "VPN check", 5, 10)
    elseif result then
      menu.notify(player.get_player_name(pid).." is using VPN.", "VPN check", 5, 10)
    else
      menu.notify(player.get_player_name(pid).." isn't VPN user.", "VPN check", 5, 10)
    end
  end
end)

menu.add_player_feature("More IP info(Geolocation)", "action", wolf_player_main_menu.id, function(feat, pid)
  local time_ = utils.time()
  system.yield(1000)
  if second == tonumber(os.date("%S", time_)) then
    vpn_check_req_num_per_min = 0
  end
  if vpn_check_req_num_per_min >= 45 then
    menu.notify("limited!(45req/min)", "IP Geolocation", 5, 10)
  else
    local ip = player.get_player_ip(pid)
    ip = string.format("%i.%i.%i.%i", ip >> 24 & 0xff, ip >> 16 & 0xff, ip >> 8 & 0xff, ip & 0xff)
    local json = http_get("http://ip-api.com/json/"..ip.."?fields=20473")
    if json ~= "Error" then
      if json:find("success") then
        json = json_to_table(json)
        local text = " - IP: "..ip.."\n - Country: "..json.country.."\n - Region: "..json.regionName.."\n - City: "..json.city.."\n - Zip: "..json.zip.."\n - Timezone: "..json.timezone.."\n - ISP: "..json.isp.."\n - Org: "..json.org.."\n - ASN: "..json.as.."\n - Latitude: "..json.lat.."\n - Longitude: "..json.lon
        print(text)
        print(#text)
        if #text <= 255 then
          menu.notify(text, player.get_player_name(pid).."'s IP Geolocation", 15, 10)
        else
          menu.notify(" - IP: "..ip.."\n - Country: "..json.country.."\n - Region: "..json.regionName.."\n - City: "..json.city.."\n - Zip: "..json.zip.."\n - Timezone: "..json.timezone.."\n - ISP: "..json.isp, player.get_player_name(pid).."'s IP Geolocation", 15, 10)
          menu.notify(" - Org: "..json.org.."\n - ASN: "..json.as.."\n - Latitude: "..json.lat.."\n - Longitude: "..json.lon, nil, 15, 10)
        end
      else
        menu.notify("fail to Detect IP Geolocation(Server Error)", "IP Geolocation", 5, 10)
      end
    else
      menu.notify("fail to Detect IP Geolocation(Server Error)", "IP Geolocation", 5, 10)
    end
  end
end)



menu.add_feature(Translate["check version"], "action", wolf_main_menu.id, function()
  menu.notify("V1.9.0", Translate["sG.wolf's script public ver"], 1, 10)
  menu.notify("sG.wolf", Translate["Developer"], 1, 2)
  menu.notify("kektram, stüssy", Translate["Special thanks to"], 1, 2)
end)

menu.notify(Translate["sG.wolf's script loaded"], Translate["sG.wolf's script public version"], 1, 1)