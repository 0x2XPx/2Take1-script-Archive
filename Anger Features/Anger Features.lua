---@diagnostic disable: undefined-field


--[[IDEAS : 
Small something to piss modder in godmode try attach invisible plane up side down under floor 
		to them with reactor flamme pushing him in the air. Will make the no ragdoll system bug




------------------  V1    ---------------------------------------------
gta Long But Gud. More advanced multiples Actions/Responses when a single or group of user defined protection or detection is triggered

Idea
When you have those detection :
-important Fps drop(user defined %), the menu/game feel problems (Para logs getting spammed with error detection) (handle loading freezes)
-Fully Loaded in lobby (FM_Create_Players ~~> Swoop_Down)
-Chat content detection : detect personal/friends RIDs, names, others
-Harmful Modder:
    #Lobby Blaming, moded Teleport all/specific player to Island/Apartment, others
    #Attachments spamming, Clone Spam attempts, Model changing spamming, chat spoofing as you or friends maybe
    #invalid se/net detection + notif : who sends to who, maybe a single option named 'Lobby Mods Detection' with a description in info box
    #every basic attacks, maybe a single option named 'Basic Attacks' with a description in info box

-Peaceful Modder: 
    #Send OTR, Never Wanted, Time, Weather, ped/vehicle godmode detection above a certain speed (avoid mini tank, Rc cars, free falling speed), Chat Spamming, others
    #Weapon detection: detect invalid weapon, invalid explosion in function of player weapon

Paragon would activate features and answer with user defined delay if possible and the possibility to send multiple of those:
-Auto activation of anti crash cam
-Individual/Spamming : Attachments, entity, Clone
-A user defined Chat message plus possibility to include player that triggered the detection (so he can read what you have to say before it happens)
-A instant/delayed normal kick/crash system. 
-And, a only host kick system (only kick when you are host, will be more unexpected/harder to track who did it & rid ban) 
-Teleport on the player sending the event (maybe with Paragon user approval, or override it, would avoid some player/friend crashes when players are around you without protection)
- Send a private message (like you do on phone>Internet>...)

--------------------------   V2  --------------------------------------
1) More advanced **multiples** Actions/Responses when **a single** or group of user defined protection or detection is triggered.

Idea [1]
When you have those detection :
-important Fps drop(user defined [50-99]% fps on last [1-5]sec, or fixed fps)
-the menu/game feeling problems (Para logs getting spammed with error detection) (handle loading freezes)
-Fully Loaded in lobby (FM_Create_Players ~~> Swoop_Down)


Paragon would activate features and answer with user defined delay if possible and the possibility to send multiple of those:
-Auto activation of anti crash cam
-A user defined Chat message

Idea [2]
When you have those detection :
-Chat content detection : detect personal/friends RIDs, names, chat spoofing as you or friends maybe, others
-Harmful Modder (with least false positive):
    #Lobby Blaming, modded Teleport all/specific player to Island/Apartment, others
    #Attachments spamming, Clone Spam attempts, Model changing spamming
    #invalid se/net detection + notif : who sends to who, maybe a single option named 'Lobby Mods Detection' with a description in info box
    #every attacks with least false positive, maybe a single option named 'All Attacks' with a description in info box

-Peaceful Modder (with least false positive): 
    #Send OTR, Never Wanted, Time, Weather, ped/vehicle godmode detection above a certain speed (take a min speed above : mini tank, Rc cars, free falling speed), Chat Spamming, others
    #Weapon detection: detect invalid weapon, invalid explosion in function of player weapon

(linked with following suggestion)
(linked with previous suggestion)

Paragon would activate features and answer with user defined delay if possible and the possibility to send multiple of those:
-Individual/Spamming : Attachments, entity, Clone, Teleport to appart/island
-A user defined Chat message plus possibility to include player that triggered the detection (so he can read what you have to say before it happens)
-A instant/delayed normal kick/crash system. 
-And, a only host kick system (only kick when you are host, will be more unexpected/harder to track who did it & rid ban) 
-Teleport on the player sending the event (maybe with Paragon user approval, or override it, would avoid some player/friend crashes when players are around you without protection)
- Send a private message (like you do on phone>Internet>...)

Paragon would activate features and answer with user defined delay if possible and the possibility to send multiple of those:
-Individual/Spamming : Attachments, entity, Clone, Teleport to appart/island
-A user defined Chat message plus possibility to include player that triggered the detection (so he can read what you have to say before it happens)
-A instant/delayed normal kick/crash system. 
-And, a only host kick system (only kick when you are host, will be more unexpected/harder to track who did it & rid ban) 
-Teleport on the player sending the event (maybe with Paragon user approval, or override it, would avoid some player/friend crashes when players are around you without protection)
- Send a private message (like you do on phone>Internet>...)






And if possible, Append to 'Player Manager > Specific Player > reason' the new detections 
		obtained for the specific player (maybe only first time we meet him/he gets saved).
	


	
 Implement clean session "nicely" near crash lobby, would instant kick only basic player with 
 the most basic kick, and send a big lobby crash once all basic/non-protected players left




Add a 'Vehicle' submenu > 'Automatic modding' with all vehicle mod you can apply to a vehicle in general 
(Neon, Horn, Paint, Liveries, wheels, ...) 
Would apply to :
-All vehicle i drive/I'm passenger of (user defined) 
-Fully tune vehicle button
Or/and Add more settings in 'Vehicle >Spawner>Settings' than the custom license plates. User Would choose 
if applied to chat commands.




-------------------------
IMPORTANT : Add a way to temporary save old 'Recent Players' from previous Paragon injection 
	(usefull if you crash, or if you want access data another way, maybe only peoples from latest lobby, list would be cleared each lobby & button to 'Add everyone in 'Player Manager' with user defined category)
Or/And Paragon could handle a file as Wright-only or Append-only. 
		This File would have one line added per person joining your lobbies without
		the need of it being loaded at anytime in the process, the file structure could be :
			'Name | RID_1, RID_2,.. | IP data maybe | 
			Special Tags (ScripH, SessH, Mod, Player_Manager_Category, ... ) | 
			Others' : (include multiple RIDs instances please in case of bad spoofing detection, it's very useful)
Only con which isnt really a con is that you'll have replication.
-------------------------




-------------------------
IMPORTANT : 
Improve 'Online > Specific Player > Self Attachment' :
- 3 axis coordinates movement
- 3 axis rotation movement

if possible will move while attached to the Player
-------------------------





				
				
				


godmode detection improvment 
(not possible ?)check if stats 'LOADING' related are changed while player is in loading





-------------------------
IMPORTANT : TODO : part not handled yet :- deletion of a modder
-------------------------






check for stat: 'CHEAT' related




-------------------------
-------------------------
IMPORTANT : 
IMPORTANT : detect spoofing RID/SCID rid<"10000000" or rid>"200000000" , HOST TOKEN (<4621266591385760) , IP (1337 6969.. look on web for normal layout), NAME strlength entre 6 et 16 char avec seulement des lettres,chiffres tirets (-) et tirets bas (_) ,  0<KDR< 50 (if player above level 10, just to be sure), 0<lvl<XXX?, 0<money<XXX?,
(read 2Take1Menu.log to have the true/ unspoofed RID)
IP perivate range : Class A: 10.0. 0.0 to 10.255. 255.255.
					Class B: 172.16. 0.0 to 172.31. 255.255.
					Class C: 192.168. 0.0 to 192.168. 255.255.
1.x.x.X to 91.X.X.X for public ip

detect teleport if possible :if entity was visibile 3 sec ago and it is still visible but distance between two points are > 

scan health modification (x>328) OR (x<238) & Armor

scan invalid weapons

detect various script/net event considered as naughty
-------------------------
-------------------------





-------------------------
IMPORTANT : aim protection detect IF YOU ARE aiming a godmode guy
-------------------------





sugestion gta griefing send sound even better if linked to godmdoe aiming detection












-------------------------
IMPORTANT : chat commands: include me, friends, crew, other player : 
Spawn  <player/all>  <cars,object,ped>, 
Kill  <player/all>, 
explode  <player/all>, 
clone  <player/all>, 
otr  <player/all>  <on/off>,
vehicle   <fix/god/max/launch/catapult/maxspeed/hornboost/clone/engine/ramp/kick>   <on/off/player/all/other>, 
time  <any time+some keywords>,
weather  <any weather keywords>,
nocops  <player/all>  <on/off/clear>,
bounty  <player/all>  <amount>,
money  <player/all> (if possible), 
rp  <player/all>  (if possible), 
!protex teleport player to 9999 9999 7777 (or around) and place  : https://gta-objects.xyz/objects/sm_prop_smug_hgrground_01
				below the player
help <command/all>
if you type the command sirectly without keywords it explain how it works
Send the command as somone (even if above alrady do)
-------------------------




add host token and ip to paragon player list, change Action : 0- None, 1-Notify, 2-Crash, 3-Bail, 4-Block Entities, 5-Freeze, 6-Explode Loop, 7-Kick, 8-BlockJoin




-------------------------
IMPORTANT : add a clear badsport/mental state feature
-------------------------


clear area for unmodified cars,etc ... to not delete player cars




rainbow paint (smooth, random), rainbow tire smoke (smooth, random), 
rainbow neon lights (smooth, random), rainbow headlights (smooth(or sequence), random) 
and link the color in between all if all activated




make a small info box to describe features according to menu X,Y position




copy outfit



kill engine of player



semi god (attachment and life bringer)



-------------------------
IMPORTANT : kick, lock, unlock vehicle
-------------------------





-------------------------
IMPORTANT : Clean the modder_flag system of 2T1 and save to files the modders or in a secondary player info-box
make a system do delete modder detection to keep 'Block From Modder' protection shit
-------------------------

copy rid, ip, name, scid




if someone try to roll on you to kill you boom a C4 near you to kill them (will kill you)




-------------------------
IMPORTANT : display os date / time overley
-------------------------



-------------------------
IMPORTANT : warn user for hotkey activation (will need to read the Default_config.ini and tell user it only work with the default_config.ini)
-------------------------
IMPORTANT : read the menu config Keys to have the user keys ans bring a pop up (thing activated) or add settings
-------------------------
IMPORTANT : why not make a system to change hostkeys with the desired one
-------------------------
Add a setting "Reload backup of default config"





make a system kick everyone excpet this guy (those guys)





Chat Bot detection if user come in in following 2 minutes he put same string 4 times then he chat bot
chat spammer detection too long message to type in under X seconds




-------------------------
IMPORTANT : detect aimbot if somone aims the same bone for more than 3 sec and i'm moving he's aimboting
-------------------------


make ped nearby reset aim ai if they  aim you




-------------------------
IMPORTANT : add User_settings["add_modder_to_blacklist.cfg_for_next_startup"]
-------------------------




log migration queue host





detecter les NET_CHECK_EXE_SIZE (avec v�rification quelconque) et demander au gens s'il mod en ligne avant m�me si possibilit� de menssonge

Puis essayer de trouver la EXE_SIZE_RESPONSE (: c'est pas �a, �a sort du cerveau) pour avoir les modders dans le lobby mouahahahahahahaah




lire les reports sur le profile actuel avec STAT ?




-------------------------
IMPORTANT : detect own vehicle passenger / driver for godmode etcc detection
-------------------------


-------------------------
IMPORTANT : Online Players > SC Friends > Modder Detection > auto whitelist/unmark as modders
-------------------------


-------------------------
IMPORTANT : add a timer after after in not_allow_vehicle_for_modder_deteciton
-------------------------

-------------------------
IMPORTANT : friend joining detection
-------------------------


-------------------------
IMPORTANT : Add a player spectating thread with D3D notify
-------------------------





PERSONNAL ONLY ::: host token black list system (thx moist)1




Add Anger Features to autoexec.lua (without deleting other auto starting)
	(Add other scripts also why not lol)
	


-------------------------
IMPORTANT : Save last 500 script event
			Send saved group of script event and see if a crash occurs on a guy (works even with SE from before a restart
-------------------------



-------------------------
IMPORTANT : Make very slow scanning of new comers from a big list of old player met 
			+check if the player has been scannnee and add him detected moder flags 
			+ add a small d3d infobox to add other modder flags (not only Anger's one)
-------------------------



-------------------------
IMPORTANT : Check if entity has been damaged while player was in GM / VGM
			with : entoty.has_entity_been_damaged_by_entity(Entity e1, Entity e2)
-------------------------

-------------------------
IMPORTANT : Check if entity has been damaged while player was detected AS MODDER
			with : entoty.has_entity_been_damaged_by_entity(Entity e1, Entity e2)
-------------------------


Delete Vehicle after 5-30 min of not used. Even if a user is on it (kick from vehicle+ delete)


Make search bar that get you through Anger Features and indicates where is located the possible option in the menu



Make a database of vehicle mods to be able to save vehicles and their modifications (next step : implement a creator using attach entity, etcc ... )



-------------------------
IMPORTANT : Add setting 'Log to notification.log'
			or log to the same file anger & 2T1 and wich file 
-------------------------




Make a release process system



Log/detect all kills (maybe looking at the gta notif with the correct label- .9++*+--)



detect friend got killed



could check if player is inside or outside with the godmode check system





iddee detect sesion switch : var glob au script time et un thread






mettre les codes d'erreur en hexa plus calcul à la con




faire is player in interior faire is player in cayo perico avec le system godmode



draw giant sign with definde chat command to attach to vehicle / player




Make modular cage system to choose whatever to put around the guy where and how





Detect entity dead for too long akak godmdoe






Set Outfits automatically on new lobby
]]









--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

--[[VERY VERY IMPORTANT TO DO-------------------------
IMPORTANT : Make a system to start threads only when : 
		- the setting managment system has been executed 
		- THE THREAD TO LOAD ALL_PLAYER_data for specific player
-------------------------]]


--[[VERY VERY IMPORTANT TO DO-------------------------
IMPORTANT : Make a kindof time-out for the script with 2T1 version + announce in the message I may make the script paid in near future
-------------------------]]

--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^












--[[ HELP :
--add a group of PlayerFeat.feats[32] handled with thefeature.id
local thefeature = menu.add_player_feature("Something", "autoaction_value_i", 0, function(feat, slot)
    --DO SOMTHING
end).id

--get the specific player feature of player 'pid' with : get_player_feature(feature_id).feats (.feats = property of PlayerFeat type)
 menu.get_player_feature(thefeature).feats[pid].value = the_value
 
 
 
 
 
 
 gta chat & name Color Codes:

				~r~ = Red
				~b~ = Blue
				~g~ = Green
				~y~ = Yellow
				~p~ = Purple
				~q~ = Pink
				~o~ = Orange
				~c~ / ~t~ = Gray
				~m~ = Dark Gray
				~u~ / ~l~ = Black
				~w~ / ~s~ White

				Other:

				~n~ = New Line
				~h~ = Bold Text
				<i> = Italics
				� = Rockstar Verified Icon
				� = Rockstar Icon
				? = Rockstar Icon 2
				~ex_r*~ = Rockstar Icon 3
				~ws~ = Wanted Star
				<font size='xx'> = xx is a number.
				<font color=#xxxx> = #xxxx is the hex code of the color you want to use.

				Emblems are inserted using five specific symbols such as:

				� = Rockstar icon Verified
				� = Rockstar icon
				? = Rockstar 2 icon
				O = Locked icon
				~ws~ = Search Star

				The problem is that these symbols cannot be inserted in a textbox in the normal way. For this reason, you should enter these symbols using decimal HTML characters. The equivalents of these characters are as follows:

				 �- &#166;
				�- &#247;
				?- &#8721;
				O- &#937;
				~WS~- &#126;WS&#126;

]]









--[[
Anger Features (made by AngerOfHell)
	reach me on discord if you have any ideas/improvments/bugs
	reach me on discord if you have a (serious) problem
Copyright AngerOfHell © year 1024 to 4096

I advise you to use a Real-Time Log Reader named : 
	- Snaketail (http://snakenest.com/snaketail/)
		It's old but perfect for the usage
]]

--Take a look at ASCII_drawing when the version will evolve
local START_UP_TIME_MS = utils.time_ms()
Anger_loading_version = "v0.1"
if Anger_loaded_version and type(Anger_loaded_version) == "string" then 
	menu.notify("Anger Features already loaded\n   (-_- ) ",""--[[no title]], 7--[[sec]], 0x0FF--[[red]])  --rgb(a)
	ui.notify_above_map("Anger Features already loaded\n   (-_- ) ","",6)
	print("Anger Features already loaded   (-_- ) ")
	error()
end

local path_2T1 = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
local path_AngerData = path_2T1.."scripts\\Anger_Data\\"
local path_2T1blacklistCFG = path_2T1.."cfg\\blacklist.cfg"
local path_2T1notifLOG = path_2T1.."notification.log"
local path_logFile = path_AngerData.."Anger.log"
local path_SavedConfigINI = path_AngerData.."Anger_UserConfig.2t1"
local path_Anger_dataLUA = path_AngerData.."Anger_data.lua"
local path_table_luaLUA = path_AngerData.."table_lua.lua"
local path_Anger_artLUA = path_AngerData.."Anger_art.lua"
local path_Anger_vehicleLUA = path_AngerData.."Anger_vehicle.lua"
local path_Anger_notifyLUA = path_AngerData.."Anger_notify.lua"
local path_PlayersJSON = path_AngerData.."Players.json"
local path_SavedModders = path_AngerData.."Anger_SavedModder.log"
local path_ErrorLOG = path_AngerData.."Anger_ERRORS.log"

local AngerFunctions = {}

--Check directory/folder existance
if not utils.dir_exists(path_AngerData) then
	utils.make_dir(path_AngerData)
end


------------------------------------------ MAIN LIBRARIES CALLING -------------------------------------------------
-- (Except AngerLib.notify that is called at bottom of code for notifications / d3d reason)

local AngerLib = {}

local temp_package = package.path
package.path = path_AngerData.."?.lua"

if utils.file_exists(path_Anger_dataLUA) then
	AngerLib.data = require("Anger_data")
	--exemple of data gathering : AngerLib.data.get_AI_task_id("CTaskNMOnFire")
else
	menu.notify("Missing data library file.", "Anger Errors", 7--[[sec]], 0x0FF--[[red]])  --rgb(a)
	error("Missing a library file.")
end
if utils.file_exists(path_Anger_artLUA) then
	AngerLib.ascii_art = require("Anger_art")
else
	menu.notify("Missing art library file.", "Anger Errors", 7--[[sec]], 0x0FF--[[red]])  --rgb(a)
	error("Missing a library file.")
end
if utils.file_exists(path_table_luaLUA) then
	AngerLib.lua_table = require("table_lua")
else
	menu.notify("Missing table_lua library file.", "Anger Errors", 7--[[sec]], 0x0FF--[[red]])  --rgb(a)
	error("Missing a library file.")
end
if utils.file_exists(path_Anger_vehicleLUA) then
	AngerLib.vehicle = require("Anger_vehicle")
else
	menu.notify("Missing vehicle library file.", "Anger Errors", 7--[[sec]], 0x0FF--[[red]])  --rgb(a)
	error("Missing a library file.")
end
--if utils.file_exists(path_Anger_notifyLUA) then
	--AngerLib.notify = require("Anger_notify")
--else
--	menu.notify("Missing notify library file.", "Anger Errors", 7--[[sec]], 0x0FF--[[red]])  --rgb(a)
--	error("Missing a library file.")
--end

package.path = temp_package

------------------------------------------   ERRORS MANAGMENT   -------------------------------------------------
-- Anger&2T1 file logging
function AngerFunctions.LogErrors(str)
	if str ~= nil and type(str) == "string" then
		if Anger_loaded_version ~= nil and type(Anger_loaded_version) == "number" then
			AngerFunctions.append_to_file_with_OsDate("["..Anger_loaded_version.."]"..str, path_ErrorLOG)
		else
			AngerFunctions.append_to_file_with_OsDate("[-->>NO_VERSION_LOADED<<--]"..str, path_ErrorLOG)
		end
	else
		if Anger_loaded_version ~= nil and type(Anger_loaded_version) == "number" then
			AngerFunctions.append_to_file_with_OsDate("["..Anger_loaded_version.."] [LOG ERRORS PROBLEM] tried to log nil value == >>> str = "..tostring(str)..";", path_ErrorLOG)
		else
			AngerFunctions.append_to_file_with_OsDate("[-->>NO_VERSION_LOADED<<--] [LOG ERRORS PROBLEM] tried to log nil value"..str, path_ErrorLOG)
		end
	end
end



------------------------------------------   DECLARATIONS   -------------------------------------------------

local AngerFeatures = {}
local ERROR = math.mininteger+10
local SUCCESS = math.mininteger+11   --or success
local INVALID_RANGE = math.mininteger+8
local find_NOT_FOUND = math.mininteger+9
local Anger_threads = {}
local JoinTimeOut_List = {}
local vehicle_DB = AngerLib.vehicle.get_vehicle_db()
local int_INPUT_RESPONSE_CODE = { SUCCESS = 0,  PENDING = 1, FAILED = 2}
local int_INPUT_TYPES = { ASCII = 0,  ALPHA = 1, ALPHA_NUM = 2, NUM = 3, NUM_DOT = 4, FLOAT = 5}
local bit_2T1_MODDER_FLAG = { 
					MDF_MANUAL                  = 1 << 0x00,
					MDF_PLAYER_MODEL            = 1 << 0x01,
					MDF_SCID_SPOOF              = 1 << 0x02,
					MDF_INVALID_OBJECT_CRASH    = 1 << 0x03,
					MDF_INVALID_PED_CRASH       = 1 << 0x04,
					MDF_MODEL_CHANGE_CRASH      = 1 << 0x05,
					MDF_PLAYER_MODEL_CHANGE     = 1 << 0x06,
					MDF_RAC                     = 1 << 0x07,
					MDF_MONEY_DROP              = 1 << 0x08,
					MDF_SEP                     = 1 << 0x09,
					MDF_ATTACH_OBJECT           = 1 << 0x0A,
					MDF_ATTACH_PED              = 1 << 0x0B,
					MDF_NET_ARRAY_CRASH         = 1 << 0x0C,
					MDF_SYNC_CRASH              = 1 << 0x0D,
					MDF_NET_EVENT_CRASH         = 1 << 0x0E,
					MDF_HOST_TOKEN              = 1 << 0x0F,
					MDF_SE_SPAM                 = 1 << 0x10,
					MDF_INVALID_VEHICLE         = 1 << 0x11,
					MDF_FRAME_FLAGS             = 1 << 0x12		}

--modder_flags name must be the same as the one in all_detected_data (=3 because int_modder_flag cant take 3)
local modder_flags = 
{
	["Ang-Godmode"] = -1,
	["Ang-VehicleGodmode"] = -1,
	["Ang-Godmode-Aiming"] = -1,
	["Ang-HealthMod"] = -1,
	["Ang-NAME_Spoof"] = -1,
	["Ang-SCID_Spoof"] = -1,
	["Ang-IP_Spoof"] = -1,
	["Ang-HOST_Spoof"] = -1
}
	
--User_settings names have to be the same as AngerFeatures.with_toggle & with_valuei
local User_settings = 
{
	["Help_My_Dev"] = true,



	----------------SETTINGS
	["General_Anger_Logging"] = true,
	["General_Anger_Notification"] = true,
	["General_Anger_Notification_Title"] = true,
	["General_Anger_Log_in_2T1notif_file"] = true,
	



	------------------MISC
	["Chat_Logging"] = true,
	["ASCII_drawing"] = 1,   --0: none 1:Anger; 2:2T1; 3: Big Skull; 4: small skull
	["Session_Host_Migration_Logging"] = true,
	["Session_Host_Migration_Notification"] = true,
	["Script_Host_Migration_Logging"] = true,
	["Script_Host_Migration_Notification"] = true,
	["ChatCommand_State"] = true,
	["Max_MentalState_State"] = true,
	["Max_MentalState_value"] = 1,
	

	
	-----------------AIMING
	["AimingProtection_Godmode_State"] = true,
	["AimingProtection_Godmode_Logging"] = true,
	["AimingProtection_Godmode_FriendAimingState"] = false,
	["AimingProtection_Godmode_FriendAimedState"] = false,
	["AimingProtection_Godmode_TeleportFriendAimedState"] = false,
	["AimingProtection_Godmode_SMSFriendAimedState"] = false,
	["AimingProtection_Godmode_SelfState"] = false,
	["AimingProtection_Godmode_RandomPlayersState"] = true,
	["AimingProtection_Godmode_Notification"] = true,
	["AimingProtection_Godmode_MarkModder"] = true,
	["AimingProtection_Godmode_SaveModder"] = true,
	["AimingProtection_Godmode_AddJoinTimeOut"] = true,
		

	
	----------------MODDER
	["Anger_Modder_detection_State"]=true,
	
	["Anger_GodMode_detection_Notification"] = true,
	["Anger_GodMode_detection_Logging"] = true,
	["Anger_GodMode_detection_FriendState"] = false,
	["Anger_GodMode_detection_SelfState"] = false,
	["Anger_GodMode_detection_State"] = true,
	["Anger_GodMode_detection_MarkModder"] = true,
	["Anger_GodMode_detection_SaveModder"] = true,
	["Anger_GodMode_detection_AddJoinTimeOut"] = true,
	
	["Anger_VehiclGodMode_detection_Notification"] = true,
	["Anger_VehicleGodMode_detection_Logging"] = true,
	["Anger_VehicleGodMode_detection_FriendState"] = false,
	["Anger_VehicleGodMode_detection_SelfState"] = false,
	["Anger_VehicleGodMode_detection_State"] = true,
	["Anger_VehicleGodMode_detection_MarkModder"] = true,
	["Anger_VehicleGodMode_detection_SaveModder"] = true,
	["Anger_VehicleGodMode_detection_AddJoinTimeOut"] = true,
	
	["Anger_Health_Mod_detection_State"] = true,
	["Anger_Health_Mod_detection_Notification"] = true,
	["Anger_Health_Mod_detection_Logging"] = true,
	["Anger_Health_Mod_detection_FriendState"] = true,
	["Anger_Health_Mod_detection_SelfState"] = false,
	["Anger_Health_Mod_detection_MarkModder"] = true,
	["Anger_Health_Mod_detection_SaveModder"] = true,
	["Anger_Health_Mod_detection_AddJoinTimeOut"] = true,
	
	
	

	----------------SPOOFING
	["Anger_NAME_Spoof_detection_Notification"] = true, 
	["Anger_NAME_Spoof_detection_Logging"] = true, 
	["Anger_NAME_Spoof_detection_FriendState"] = true, 
	["Anger_NAME_Spoof_detection_SelfState"] = false,   
	["Anger_NAME_Spoof_detection_State"] = true, 
	["Anger_NAME_Spoof_detection_MarkModder"] = true,  
	["Anger_NAME_Spoof_detection_SaveModder"] = true,
	["Anger_NAME_Spoof_detection_AddJoinTimeOut"] = true,
	
	["Anger_RID_Spoof_detection_Notification"] = true, 
	["Anger_RID_Spoof_detection_Logging"] = true, 
	["Anger_RID_Spoof_detection_FriendState"] = true, 
	["Anger_RID_Spoof_detection_SelfState"] = false,  
	["Anger_RID_Spoof_detection_State"] = true, 
	["Anger_RID_Spoof_detection_MarkModder"] = true,  
	["Anger_RID_Spoof_detection_SaveModder"] = true,
	["Anger_RID_Spoof_detection_AddJoinTimeOut"] = true,
	
	["Anger_IP_Spoof_detection_Notification"] = true, 
	["Anger_IP_Spoof_detection_Logging"] = true, 
	["Anger_IP_Spoof_detection_FriendState"] = true, 
	["Anger_IP_Spoof_detection_SelfState"] = false,  
	["Anger_IP_Spoof_detection_State"] = true, 
	["Anger_IP_Spoof_detection_MarkModder"] = true,  
	["Anger_IP_Spoof_detection_SaveModder"] = true,
	["Anger_IP_Spoof_detection_AddJoinTimeOut"] = true,
	
	["Anger_HOST_TOKEN_Spoof_detection_Notification"] = true, 
	["Anger_HOST_TOKEN_Spoof_detection_Logging"] = true, 
	["Anger_HOST_TOKEN_Spoof_detection_FriendState"] = true,
	["Anger_HOST_TOKEN_Spoof_detection_SelfState"] = false,  
	["Anger_HOST_TOKEN_Spoof_detection_State"] = true,
	["Anger_HOST_TOKEN_Spoof_detection_MarkModder"] = true,
	["Anger_HOST_TOKEN_Spoof_detection_SaveModder"] = true,
	["Anger_HOST_TOKEN_Spoof_detection_AddJoinTimeOut"] = true,


	
	

	["nothing"] = nil
}
local seats = 
{
	["none"] = -3,
	["any"] = -2,
	["driver-left_front"] = -1,
	["passenger-right_front"] = 0,
	["left_rear"] = 1,
	["right_rear"] = 2,
	["extra_1"] = 3,
	["extra_2"] = 4,
	["extra_3"] = 5,
	["extra_4"] = 6,
	["extra_5"] = 7,
	["extra_6"] = 8,
	["extra_7"] = 9,
	["extra_8"] = 10,
	["extra_9"] = 11,
	["extra_10"] = 12,
	["extra_11"] = 13,
	["extra_12"] = 14
}
local idx_vehicle_wheels = 
{
	FrontLeft = 0,
	FrontRight = 1,
	MiddleLeft = 2,
	MiddleRight = 3,
	BackLeft = 4,
	BackRight = 5,
	SecondMidLeft = 45,
	SecondMidRight = 47
}
local HASH_vehicles = 
{
	["minitank"]=0xB53C6C52,   --uint32: 3040635986    int32 : -1254331310
	["rcbandito"]=0xEEF345EC,   --uint32: 4008920556    int32 : -286046740
	["kosatka"] = 0x4FAF0D70
}
local health = 
{
	["max"]=328,
	["min"]=238
}


------------------------------------------     UTILS      -------------------------------------------------

-------------------- RGBA & IP_HosToken_dec_hex_bin_convertion & time_format_convertion & math UTILS

function AngerFunctions.Anger_log_date()
	return os.date("%Y-%m-%d %H:%M:%S")
end


--RGBA_to_uint32_t(int r, int g, int b, int a) 
--@exemple : RGBA_to_uint32_t(255, 0, 255, 127) gives : 0x7FFF00FF
function AngerFunctions.RGBA_to_int32_t(r, g, b, a)

	--uint_32 color behavior: 0xAABBGGRR
	if type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number" or type(a) ~= "number"
		or r > 255 or r < 0 or g > 255 or g < 0 or b > 255 or b < 0 or a > 255 or a < 0 
	then
		AngerFunctions.LogErrors("[ERROR:RGBAto32bit]: illegal parameter : "..
		"== >>> r = "..tostring(r).."; g = "..tostring(g).."; b = "..tostring(b)..
		"; a = "..tostring(a)..";")
		
		return ERROR
	else
		local color_to_return = 0x00000000
			color_to_return = (r) << 0  |
								(g) << 8  |
								(b) << 16 |
								(a) << 24
		return color_to_return
	end
end


function AngerFunctions.dec_to_hex_UPPER(dec)
	if dec~=nil and type(dec) == "number" then
		return string.upper(tostring(string.format("%x", tostring(dec))))
	else
		AngerFunctions.LogErrors("[ERROR:dec_to_hex]: illegal parameter : "..
		"== >>> dec = "..tostring(dec)..";")
		
		return ERROR
	end
end

function AngerFunctions.dec_to_hex_LOWER(dec)
	if dec~=nil and type(dec) == "number" then
		return tostring(string.format("%x", tostring(dec)))
	else
		AngerFunctions.LogErrors("[ERROR:dec_to_hex]: illegal parameter : "..
		"== >>> dec = "..tostring(dec)..";")
		
		return ERROR
	end
end


function AngerFunctions.intIP_to_strIP(n)
    n = tonumber(n)
	if n ~= nil and type(n) == "number" and n ~= ERROR then
		local n1 = math.floor(n / (2^24)) 
		local n2 = math.floor((n - n1*(2^24)) / (2^16))
		local n3 = math.floor((n - n1*(2^24) - n2*(2^16)) / (2^8))
		local n4 = math.floor((n - n1*(2^24) - n2*(2^16) - n3*(2^8)))
		return n1.."."..n2.."."..n3.."."..n4    , n1, n2, n3, n4
	else
		AngerFunctions.LogErrors("[ERROR:intToIp]: \"n\" bad type or nil : "..
		"== >>> n = "..tostring(n)..";")
		
		return ERROR
	end
end

function AngerFunctions.float_round_to_integer(x)
	if x ~= nil and type(x) == "number" and x ~= ERROR then
		return x + 0.5 - (x + 0.5) % 1
	else
		AngerFunctions.LogErrors("[ERROR:round_to_integer]: \"x\" bad type or nil : "..
		"== >>> x = "..tostring(x)..";")
		
		return ERROR
	end
end



-------------------- geometric/coord UTILS


--v3(P), v2(rect_a)..., int z...
function AngerFunctions.dist_2_point_in_2D_only(Pa, Pb)
	if Pa ~= nil and Pb ~= nil and type(Pa) == "userdata" and type(Pb) == "userdata" then
		return math.sqrt((Pb.x - Pa.x)^(2) + (Pb.y - Pa.y)^(2))
	else
		AngerFunctions.LogErrors("[ERROR:dist_2_point_in_2D_only]: \"Pa\" or \"Pb\" bad type or nil : "..
		"== >>> x = "..tostring(Pa).."; Pb = "..tostring(Pb)..";")
		
		return ERROR
	end
end

--v3(P), v2(rect_a)..., int z...
function AngerFunctions.area_triangle_3_point_in_2D_only(Pa, Pb, Pc)
	if Pa ~= nil and Pb ~= nil and Pc ~= nil and type(Pa) == "userdata" 
	 and type(Pb) == "userdata" and type(Pc) == "userdata" 
	then
		return 1/2 * math.abs( Pa.x*(Pb.y - Pc.y) + Pb.x*(Pc.y - Pa.y) + Pc.x*(Pa.y - Pb.y))
	else
		AngerFunctions.LogErrors("[ERROR:area_triangle_3_point_in_2D_only]: \"Pa\" or \"Pb\" or \"Pc\" bad type or nil : "..
		"== >>> x = "..tostring(Pa).."; Pb = "..tostring(Pb).."; Pc = "..tostring(Pc)..";")
		
		return ERROR
	end
end

--v3(P), v2(rect_a)..., int z...
function AngerFunctions.area_of_quadrilatere_in_2D_only(Pa, Pb, Pc, Pd)
	if Pa ~= nil and Pb ~= nil and Pc ~= nil and Pd ~= nil and type(Pa) == "userdata" 
	 and type(Pb) == "userdata" and type(Pc) == "userdata" and type(Pd) == "userdata" 
	then
		return ((AngerFunctions.area_triangle_3_point_in_2D_only(Pa, Pb, Pc)) + (AngerFunctions.area_triangle_3_point_in_2D_only(Pa, Pc, Pd)))
	else
		AngerFunctions.LogErrors("[ERROR:area_of_quadrilatere_in_2D_only]: \"Pa\" or \"Pb\" or \"Pc\" or \"Pd\" bad type or nil : "..
		"== >>> x = "..tostring(Pa).."; Pb = "..tostring(Pb).."; Pc = "..tostring(Pc).."; Pd = "..tostring(Pd)..";")
		
		return ERROR
	end
end

--v3(P), v2(rect_a)..., int z...
function AngerFunctions.is_point_in_quadrilatere_3D_only(P, quad_a, quad_b, quad_c, quad_d, z_max_altitude, z_min_altitude)
	if P ~= nil and quad_a ~= nil and quad_b ~= nil and quad_c ~= nil and quad_d ~= nil 
	 and z_max_altitude ~= nil and z_min_altitude ~= nil and type(P) == "userdata" 
	 and type(quad_a) == "userdata" and type(quad_b) == "userdata" and type(quad_c) == "userdata"
	 and type(quad_d) == "userdata"	and type(z_max_altitude) == "number" and type(z_min_altitude) == "number"
	 and z_max_altitude ~= ERROR and z_min_altitude ~= ERROR
	then
		if P.z ~= nil then
			--if the point is in the good part of the Z axis
			if P.z < z_max_altitude and P.z > z_min_altitude then
				return AngerFunctions.is_point_in_quadrilatere_2D_only(P, quad_a, quad_b, quad_c, quad_d)
			else
				return false
			end
		else
			AngerFunctions.LogToFile_AngerAnd2T1("P.z is nil")
			return ERROR
		end
	else
		AngerFunctions.LogErrors("[ERROR:is_point_in_quadrilatere_3D_only]: \"P\" or \"quad_a\" or \"quad_b\" or \"quad_c\" or \"quad_d\" or \"z_max_altitude\" or \"z_min_altitude\" bad type or nil : "..
		"== >>> P = "..tostring(P).."; quad_a = "..tostring(quad_a).."; quad_b = "..tostring(quad_b).."; quad_c = "..tostring(quad_c).."; quad_d = "..tostring(quad_d)..
		"; z_max_altitude = "..tostring(z_max_altitude).."; z_min_altitude = "..tostring(z_min_altitude)..";")
		
		return ERROR
	end
		
end


--v3(P), v2(rect_a)..., int z...
function AngerFunctions.is_point_in_quadrilatere_2D_only(P, quad_a, quad_b, quad_c, quad_d)
	
	if P ~= nil and quad_a ~= nil and quad_b ~= nil and quad_c ~= nil and quad_d ~= nil and type(P) == "userdata" 
	 and type(quad_a) == "userdata" and type(quad_b) == "userdata" and type(quad_c) == "userdata"
	 and type(quad_d) == "userdata" 
	then
	
		local quadrilatere_area = AngerFunctions.area_of_quadrilatere_in_2D_only(quad_a, quad_b, quad_c, quad_d)
		local sum_of_small_triangle =  AngerFunctions.area_triangle_3_point_in_2D_only(quad_a, P, quad_d) +
									   AngerFunctions.area_triangle_3_point_in_2D_only(quad_d, P, quad_c) +
									   AngerFunctions.area_triangle_3_point_in_2D_only(quad_c, P, quad_b) +
									   AngerFunctions.area_triangle_3_point_in_2D_only(P, quad_b, quad_a) 
		--if the point is in the x,y axis quadrilatere
		if sum_of_small_triangle <= quadrilatere_area 
		then
			return true
		else
			return false
		end
	else
		AngerFunctions.LogErrors("[ERROR:is_point_in_quadrilatere_2D_only]: \"P\" or \"quad_a\" or \"quad_b\" or \"quad_c\" or \"quad_d\" bad type or nil : "..
		"== >>> P = "..tostring(P).."; quad_a = "..tostring(quad_a).."; quad_b = "..tostring(quad_b).."; quad_c = "..tostring(quad_c).."; quad_d = "..tostring(quad_d)..
		";")
		
		return ERROR
	end
		
end




-------------------- Array & table UTILS

--becasue i was tired of thos shit for loop inpairs shit my ass
function AngerFunctions.table_or_array_Length(the_table)
	if the_table ~= nil and type(the_table) == "table" then
		local count = 0
		for key, value in pairs(the_table) do 
			count = count + 1
		end
		
		return count
	else
		AngerFunctions.LogErrors("[ERROR:table_or_array_Length]: the_table bad type or nil == >>> the_table = "..
		tostring(the_table)..";")
		
		
		return ERROR
	end
end

--@return : key, value found in table
function AngerFunctions.table_or_array_Find(the_table, data_to_find)
	if the_table ~= nil and type(the_table) == "table" 
	 and data_to_find ~= nil
	then
		
		for key, value in pairs(the_table) do 
			if key == data_to_find or value == data_to_find then
				return key, value
			end
		end
	else
		AngerFunctions.LogErrors("[ERROR:table_or_array_Find]: the_table bad type or nil == >>> the_table = "..
		tostring(the_table)..";")
		
		return ERROR
	end
end


--(input/output str,input/output table, str_type [c:concatenate or s:split] )
function AngerFunctions.concatenate_or_split_str_to_char_table(str, table, str_type)
	if str ~= nil and type(str) == "string" and table ~= nil and type(table) == "table" then
		
		if str_type == "c" then
			-----TESTING
			--AngerFunctions.LogToFile_AngerAnd2T1("c type,")
			-----TESTING
			for i = 1, #table do
				-----TESTING
				--AngerFunctions.LogToFile_AngerAnd2T1("table[i]:"..tostring(table[i]))
				-----TESTING

				if table[i] ~= nil and type(table[i]) == "string" then
					str = str..table[i]
					-----TESTING
					--AngerFunctions.LogToFile_AngerAnd2T1("pending:"..tostring(str))
					-----TESTING
				end
			end

			-----TESTING
			--AngerFunctions.LogToFile_AngerAnd2T1("OUTPUT:"..tostring(str))
			-----TESTING

			return str
		elseif str_type == "s" then
			-----TESTING
			--AngerFunctions.LogToFile_AngerAnd2T1("s type")
			-----TESTING
			local a_char = ""
			local counter_0_based = 0
			
			while str:sub(counter_0_based, counter_0_based+2) ~= nil do
				table[counter_0_based+1] = str:sub(counter_0_based, counter_0_based+2)
				counter_0_based = counter_0_based + 1
			end

			return table
		end
	end
end



-------------------- file UTILS



--[[function get_Saved_Players_Data()  --for the lost one
	if utils.file_exists(path_PlayersJSON) then
	
		local file = io.open(path_PlayersJSON, "rb")
		local str = ""
		
		if file and type(str) == "string" then
			str = file:read("*all")
		end
		file:flush()
		file:close()
		
		local somejsonoutput = json.decode(str)
		local file = io.open(path_AngerData.."test.lua", "rb")
		file:write(somejsonoutput)
		file:flush()
		file:close()
		
		local newstr = json.encode(somejsonoutput)
		local file = io.open(path_AngerData.."test.json", "rb")
		file:write(newstr)
		file:flush()
		file:close()
		
		
	end
end]]


function AngerFunctions.rewrite_whole_file(str, file_path)
	if str ~= nil and file_path ~= nil and type(str) == "string" and type(file_path) == "string" then
		local file = io.open(file_path, "w") 
		-- Append or Create 'file'
		file:write(str)
		
		file:flush()
		file:close()
		
		return SUCCESS
	else
		AngerFunctions.LogErrors("[ERROR:append_to_file]: \"str\" or \"file_path\" bad type or nil : "..
		"== >>> str = "..tostring(str).."; file_path = "..tostring(file_path)..";")
		
		return ERROR
	end
end


function AngerFunctions.append_to_file(str, file_path)
	if str ~= nil and file_path ~= nil and type(str) == "string" and type(file_path) == "string" then
		local logfile = io.open(file_path, "a") 
		-- Append or Create 'file'
		logfile:write(str.."\n")
		
		logfile:close()
		
		return SUCCESS
	else
		AngerFunctions.LogErrors("[ERROR:append_to_file]: \"str\" or \"file_path\" bad type or nil : "..
		"== >>> str = "..tostring(str).."; file_path = "..tostring(file_path)..";")
		
		return ERROR
	end
end


function AngerFunctions.append_to_file_with_OsDate(str, file_path)
	if str ~= nil and file_path ~= nil and type(str) == "string" and type(file_path) == "string" then
		
		if AngerFunctions.append_to_file("["..tostring(AngerFunctions.Anger_log_date()).."]: "..tostring(str), file_path) == SUCCESS then
			return SUCCESS
		else
			AngerFunctions.LogErrors("[ERROR:append_to_file_with_OsDate]: error in \"append_to_file\" : "..
			"== >>> str = "..tostring(str).."; file_path = "..tostring(file_path)..";")
			
			return ERROR
		end
	else
		AngerFunctions.LogErrors("[ERROR:append_to_file_with_OsDate]: \"str\" or \"file_path\" bad type or nil : "..
		"== >>> str = "..tostring(str).."; file_path = "..tostring(file_path)..";")
		
		return ERROR
	end
end


function AngerFunctions.read_file_in_a_single_string(file_path)
	if file_path ~= nil and type(file_path) == "string" 
	 and utils.file_exists(file_path)
	then
		local file = io.open(path_SavedConfigINI, "r") --r: read
		local str = ""
		
		if file ~= nil then
			str = file:read("*all")
		end
		
		file:close()
		
		return str
	else
		AngerFunctions.LogErrors("[ERROR:read_file_in_a_single_string]:  \"file_path\" bad type or nil OR file don't exist : == >>> file_path = "..tostring(file_path)..";")
		
		return ERROR
	end
end



------------------------------------------   ANGER  UTILS   -------------------------------------------------


-- Anger&2T1 file logging
local ASCII_Art_Not_Finished = true
function AngerFunctions.LogToFile_AngerAnd2T1(str)
	if (User_settings["General_Anger_Logging"] or ASCII_Art_Not_Finished)
	 and type(str) == "string"
	then
		if User_settings["General_Anger_Log_in_2T1notif_file"] then
			if AngerFunctions.append_to_file_with_OsDate(str, path_2T1notifLOG) == SUCCESS then
				return SUCCESS
			else
				AngerFunctions.LogErrors("[ERROR:LogToFile_AngerAnd2T1]:  error called from append_to_file_with_OsDate : == >>> str = "..tostring(str)..";")
				return ERROR
			end
		else
			if AngerFunctions.append_to_file_with_OsDate(str, path_logFile) == SUCCESS then
				return SUCCESS
			else
				AngerFunctions.LogErrors("[ERROR:LogToFile_AngerAnd2T1]:  error called from append_to_file_with_OsDate : == >>> str = "..tostring(str)..";")
				return ERROR
			end
		end
	else
		AngerFunctions.LogErrors("[ERROR:LogToFile_AngerAnd2T1]:  \"str\" bad type or nil : == >>> str = "..tostring(str)..";")
		
		return ERROR
	end
end


-- Anger&2T1 file logging
local ASCII_Art_Not_Finished = true
function AngerFunctions.Save_to_JoinTimeOut(int_scid, string_name)
	if int_scid ~= nil and string_name ~= nil
	 and type(string_name) == "string" and type(int_scid) == "number"
	then
		local str = tostring(string_name)..":"..tostring(AngerFunctions.dec_to_hex_LOWER(int_scid))

		if AngerFunctions.append_to_file(str, path_2T1blacklistCFG) == SUCCESS then
			return SUCCESS
		else
			AngerFunctions.LogErrors("[ERROR:Save_to_JoinTimeOut]: error called from append_to_file : == >>> string_name = "..
			tostring(string_name)..
			"; int_scid = "..tostring(int_scid)..";")

			menu.notify("Error adding to blacklist.cfg == >>> "..tostring(string_name)..":"..tostring(int_scid))
			AngerFunctions.LogToFile_AngerAnd2T1("Error adding to blacklist.cfg == >>> "..tostring(string_name)..":"..tostring(int_scid))

			return ERROR
		end
	else
		AngerFunctions.LogErrors("[ERROR:Save_to_JoinTimeOut]:  \"string_name\" or \"int_scid\" bad type or nil : == >>> string_name = "..
			tostring(string_name)..
			"; int_scid = "..tostring(int_scid)..";")

			menu.notify("Error adding to blacklist.cfg == >>> "..tostring(string_name)..":"..tostring(int_scid))
			AngerFunctions.LogToFile_AngerAnd2T1("Error adding to blacklist.cfg == >>> "..tostring(string_name)..":"..tostring(int_scid))
		
		return ERROR
	end
end

function AngerFunctions.from_thread_scan_2T1_BlackList()
	if utils.file_exists(path_2T1blacklistCFG) then
		if AngerFunctions.read_file_in_a_single_string(path_2T1blacklistCFG) == SUCCESS then
			--TODO HERE : extract each line to save in JoinTimeOut_List
			JoinTimeOut_List = {}

			
			return SUCCESS
		else
			AngerFunctions.LogErrors("[ERROR:from_thread_scan_2T1_BlackList]:  error called from read_file_in_a_single_string : == >>> path_2T1blacklistCFG = "..tostring(path_2T1blacklistCFG)..";")
			return ERROR
		end
	else
		AngerFunctions.LogErrors("[ERROR:LogToFile_AngerAnd2T1]:  \"str\" bad type or nil : == >>> str = "..tostring("TODO")..";")
		
		return ERROR
	end
end


--167 = "green" ; 140 = "black" ; 220= "cyan"; 6 = "red"
local Anger_notify_start_up = true
function AngerFunctions.Anger_notify(str, color, duration_sec)
	if User_settings["General_Anger_Notification"] or Anger_notify_start_up then
		if Anger_notify_start_up then Anger_notify_start_up = false end
		
		local title
		--test if not nil (avoid problems and useless notif)
		if str ~= nil and type(str) == "string" then
			if type(color) == "number" and color >= 0 and color <= 0xFFFFFFFF 
             and type(duration_sec) == "number" and duration_sec >= 0
			then
				
				if User_settings["General_Anger_Notification_Title"] == true 
				then 
					menu.notify(str, "Anger "..Anger_loaded_version, duration_sec--[[sec]], color)  --rgb(a)
				else
					menu.notify(str, "", duration_sec--[[sec]], color)  --rgb(a)
				end
				--ui.notify_above_map(str, "Anger "..Anger_loaded_version, 6)
				
				return SUCCESS
				
			elseif color == nil then
				menu.notify(str, "Anger "..Anger_loaded_version, 10--[[sec]], AngerFunctions.RGBA_to_int32_t(255,255,0,255))  --rgb(a)
				
				AngerFunctions.LogErrors("[ERROR:Anger_notify]:bad parameter : "..
				"== >>> color = "..tostring(color)..";\n duration_sec = "..tostring(duration_sec)..
				";\n str = "..tostring(str).."\n\n")
				
				return ERROR
			end
		else
			AngerFunctions.LogErrors("[ERROR:Anger_notify]:bad parameter : "..
			"== >>> color = "..tostring(color)..";\n duration_sec = "..tostring(duration_sec)..
			";\n str = "..tostring(str).."\n\n")
			
			menu.notify("[ERROR:Anger_notify]: A problem occured. Notification not dislpayed. To have more info: \"%appdata%/...2T1/scripts/Anger_Data/Anger_ERRORS.log\"", "Anger "..Anger_loaded_version, 10--[[sec]], AngerFunctions.RGBA_to_int32_t(255,0,0,255))  --rgb(a)
			
			return ERROR
		end
	end
end

 
-- Anger&2T1 file logging
function AngerFunctions.SaveModders(str)
	if str ~= nil and type(str) == "string" then
		if AngerFunctions.append_to_file_with_OsDate(str, path_SavedModders) == SUCCESS then
			return SUCCESS
		else
			AngerFunctions.LogErrors("[ERROR:LogToFile_AngerAnd2T1]:  \"str\" bad type or nil : == >>> str = "..tostring(str)..";")
		end
	else
		AngerFunctions.LogErrors("[ERROR:LogToFile_AngerAnd2T1]:  \"str\" bad type or nil : == >>> str = "..tostring(str)..";")
		
		return ERROR
	end
end

--[[function thread_log2T1()
	local current_notif_string = nil
	local previous_notif_string = nil
	
	while true do
		current_notif_string = ui.get_label_text("STRING")
		
		-- if we have a current notif and current_notif is different from previous_ notif
		if current_notif_string and current_notif_string ~= previous_notif_string then
			LogToFile_AngerAnd2T1(current_notif_string) 
			previous_notif_string = current_notif_string
		end
		system.yield(200) --Avoid freezes, pause the thread for XXX ms and resume
	end
end]]


function AngerFunctions.get_user_input(str_title, str_default, int_length, int_type)
	local code, response = input.get(str_title, str_default, int_length, int_type)
	
	-----TESTING
	--AngerFunctions.LogToFile_AngerAnd2T1("get_user_input:called")
	-----TESTING

	if code ~= int_INPUT_RESPONSE_CODE.SUCCESS then
		-----TESTING
		--AngerFunctions.LogToFile_AngerAnd2T1("code ~= int_INPUT_RESPONSE_CODE.SUCCESS")
		-----TESTING
		if code == int_INPUT_RESPONSE_CODE.FAILED then
			-----TESTING
			--AngerFunctions.LogToFile_AngerAnd2T1("code == int_INPUT_RESPONSE_CODE.FAILED")
			-----TESTING
			
		elseif code == int_INPUT_RESPONSE_CODE.PENDING then
			-----TESTING
			--AngerFunctions.LogToFile_AngerAnd2T1("code == int_INPUT_RESPONSE_CODE.PENDING")
			-----TESTING
			code, response = input.get(str_title, str_default, int_length, int_type)
			
			repeat
				code, response = input.get(str_title, str_default, int_length, int_type)
				system.yield(100)
			until code == int_INPUT_RESPONSE_CODE.SUCCESS or code == int_INPUT_RESPONSE_CODE.FAILED

			-----TESTING
			--AngerFunctions.LogToFile_AngerAnd2T1("END code == int_INPUT_RESPONSE_CODE.SUCCESS or FAILED")
			-----TESTING
		end
	end

	return response
end


function AngerFunctions.init_modder_flags()

	--[[risky infinite loop
	while player.get_modder_flag_ends() == nil do
		--nothing just wait
	end]]
	
	local go_through_big_while = false
	
	if modder_flags ~= nil and type(modder_flags) == "table" then
		for key, value in pairs(modder_flags) do
			modder_flags[key] = player.add_modder_flag(key)
			-----TESTING
			--LogToFile_AngerAnd2T1(tostring(modder_flags[key]).." is now "..tostring(key).."(or '0')")
			-----TESTING
			
			--add_modder_flag returns 0 if the modder flag is alreday loaded
			if modder_flags[key] == 0 then 
				go_through_big_while = true
			end
		end
	else
		AngerFunctions.LogErrors("[ERROR:init_modder_flags]: modder_flags bad type or nil == >>> modder_flags = "..
		tostring(modder_flags)..";")
		
		--Anger_notify(str, color, duration_sec)
		AngerFunctions.Anger_notify("[ERROR] Please, Reload Anger Features.\nMajor impact error !", AngerFunctions.RGBA_to_int32_t(255,0,0,255), 15)
		
		return ERROR
	end
	
	
	--NO NEED ANYMORE but here as security
	local flag_end = player.get_modder_flag_ends()
	local int_flag = 1
	
	--for each existing modder_flag already loaded in 2T1
	while int_flag < flag_end and go_through_big_while == true do
	
		--for each modder_flag used by Anger Features
		for key, value in pairs(modder_flags) do
			if value == -1 or value == 0 then
				--test if "key" (modder_flag) used by Anger Features is already loaded in 2T1
				if player.get_modder_flag_text(int_flag) == key then
					modder_flags[key] = int_flag
					-----TESTING
					--LogToFile_AngerAnd2T1(tostring(modder_flags[key]).." looks to be "..tostring(key))
					-----TESTING
				end
			end
			
		end
		
		int_flag = int_flag << 1 
		
	end
end
--[[Anger_threads["init_modder_flags"] = menu.create_thread(xxxxxxxxxxx, 0)]]
AngerFunctions.init_modder_flags()





------TESTING
function AngerFunctions.TESTING(name, scid, ip, host_token)
	
	local TESTINGfile = io.open(path_AngerData.."TESTING_PLAYER.txt", "a") 
	-- Append or Create 'file'
	TESTINGfile:write("["..tostring(AngerFunctions.Anger_log_date()).."]: ".." | "..
	tostring(AngerFunctions.dec_to_hex_UPPER(host_token)).." | "..
	tostring(host_token).." | "..
	tostring(scid).." | "..
	tostring(AngerFunctions.intIP_to_strIP(ip)).." | "..
	tostring(ip).." | "..
	tostring(name).." | "..
	"\n")
	
	TESTINGfile:close()						
end
------TESTING







------------------------------------------   GTA  UTILS   -------------------------------------------------

function AngerFunctions.request_ctrl_of_entity(entity, timeout)
	network.request_control_of_entity(entity)
	local Ang_timeout_begin = utils.time_ms()
	while not network.has_control_of_entity(entity) and utils.time_ms() - Ang_timeout_begin < timeout do
		system.yield(0)
		-------TESTING
		--AngerFunctions.LogToFile_AngerAnd2T1("control timeout 1:"..tostring(utils.time_ms() - Ang_timeout_begin).." control : "..tostring(network.has_control_of_entity(entity)))
		-------TESTING
	end
end



-------------------------
----------------------- 
--[[IMPORTANT : 
IMPORTANT : detect spoofing 
RID/SCID rid<"10000000" or rid>"200000000" , 
HOST TOKEN (<4621266591385760) , 
IP (1337 6969.. look on web for normal layout), 
NAME strlength entre 6 et 16 char avec seulement des lettres,
	chiffres tirets (-) et tirets bas (_) ,  0<KDR< 50 (if player above level 10, just to be sure), 0<lvl<XXX?, 0<money<XXX?,


(read 2Take1Menu.log to have the true/ unspoofed RID)
IP perivate range : Class A: 10.0. 0.0 to 10.255. 255.255.
					Class B: 172.16. 0.0 to 172.31. 255.255.
					Class C: 192.168. 0.0 to 192.168. 255.255.
1.x.x.X to 91.X.X.X for public ip

detect teleport if possible :if entity was visibile 3 sec ago and it is still visible but distance between two points are > 

scan health modification (x>328) OR (x<238) & Armor

scan invalid weapons

detect various script/net event considered as naughty
]] -------------------------
-------------------------

local possible_imaginated_name = {
	[1] = "MrBigFTW",
	[2] = "Mr_Big_FTW"
}


local possible_imaginated_scid = {
	[1] = 12345678,
	[2] = 1234567890,
	[3] = 69696969,
	[4] = 6969696969,
	[5] = 420420420,
	[6] = 69420420,
	[7] = 696969420,
	[8] = 13371337
}

--[[local possible_imaginated_ip = {
	[1] = 69,
	[2] = 42,
}]]

local possible_imaginated_ip_multiple_param = {
	[2] = {123, 234, 123, 234},
	[4] = {13, 37, 13, 37},
	[5] = {13, 37, 69, 69},
	[6] = {69, 69, 13, 37},
	[8] = {69, 13, 37, 69},
	[9] = {4, 2, 0, 0},
	[10] = {0, 4, 2, 0},
	[11] = {1, 2, 4, 8},
	[12] = {2, 4, 8, 16},
	[13] = {4, 8, 16, 32},
	[14] = {8, 16, 32, 64},
	[15] = {16, 32, 64, 128},
	[16] = {32, 64, 128, 255},
	[17] = {1, 3, 3, 7},
	[18] = {6, 9, 6, 9}
}

--need to go take the scid from the logs once 2T1 triggered a SCID spoof (i guess if instance_1 != instance_2)
function AngerFunctions.scan_for_spoofing(pid ,name, scid, int_ip, int_host_token)
	local name_spoof = false
	local scid_spoof = false
	local ip_spoof = false
	local ht_spoof = false
	local str_ip
	local ip = {}
	str_ip, ip.n1, ip.n2, ip.n3, ip.n4 = AngerFunctions.intIP_to_strIP(int_ip)
	local strhex_ht = AngerFunctions.dec_to_hex_LOWER(int_host_token)
	-------TESTING
	--LogToFile_AngerAnd2T1("ip.n1:"..tostring(ip.n1).." ip.n2:"..tostring(ip.n2).." ip.n3:"..tostring(ip.n3).." ip.n4:"..tostring(ip.n4))
	-------TESTING
	if string.len(name) >= 6 and string.len(name) <= 16 and string.find(name, "[^%.%w_-]+") == nil then
		for key, value in pairs(possible_imaginated_name) do
			-------TESTING
			--LogToFile_AngerAnd2T1(name..":name=?=value:"..value)
			-------TESTING
			if name:find("^"..value.."$") then
				name_spoof = true

				-------TESTING
				--LogToFile_AngerAnd2T1("name_spoof1: "..tostring(value))
				-------TESTING
				break;
			end
		end
	else
		-------TESTING
		--LogToFile_AngerAnd2T1("name_spoof2")
		-------TESTING
		name_spoof = true
	end


	if int_host_token >= 0 and int_host_token < 100000000000000 then
		-------TESTING
		--LogToFile_AngerAnd2T1("ht_spoof")
		-------TESTING
		ht_spoof = true
	end
			  		  
	if scid > 1000000 and scid < 200000000 then
		-------TESTING
		--LogToFile_AngerAnd2T1("in_scid_spoof")
		-------TESTING
		for key2, possibility in pairs(possible_imaginated_scid) do
			-------TESTING
			--LogToFile_AngerAnd2T1("in_scid_spoof:"..possibility.."!!"..scid)
			-------TESTING
			if tonumber(scid) == tonumber(possibility) then
				scid_spoof = true
				-------TESTING
				--LogToFile_AngerAnd2T1("scid_spoof1: "..possibility)
				-------TESTING
				break;
			end
		end
	else
		-------TESTING
		--LogToFile_AngerAnd2T1("scid_spoof2")
		-------TESTING
		scid_spoof = true
	end

	
	if User_settings["Anger_IP_Spoof_detection_State"] then
		
		if
		 --check if each sub-ip is in the correct number range
		 ip.n1 > 0 and ip.n1 < 255 and ip.n2 > 0 and ip.n2 < 255  
		 and ip.n3 > 0 and ip.n3 < 255 and ip.n4 > 0 and ip.n4 < 255
		 --check the sub-ip amount = 4
		 and AngerFunctions.table_or_array_Length(ip) == 4
		 --check if there is repeted / simply additionned value in the ip sub values
		 and (ip.n1 ~= ip.n2 and ip.n2 ~= ip.n3)
		  or (ip.n1 ~= ip.n3 and ip.n3 ~= ip.n4)
		  or (ip.n2 ~= ip.n3 and ip.n3 ~= ip.n4)
		  or (ip.n1 ~= ip.n2 and ip.n2 ~= ip.n4)
		  --(+-1)(+-2)
		  or (ip.n2 ~= ip.n1+1 and ip.n3 ~= ip.n2+1 and ip.n4 ~= ip.n3+1)
		  or (ip.n2 ~= ip.n1+2 and ip.n3 ~= ip.n2+2 and ip.n4 ~= ip.n3+2)
		  or (ip.n2 ~= ip.n1-1 and ip.n3 ~= ip.n2-1 and ip.n4 ~= ip.n3-1)
		  or (ip.n2 ~= ip.n1-2 and ip.n3 ~= ip.n2-2 and ip.n4 ~= ip.n3-2)
		  --(*2:bin)
		  or (ip.n2 ~= ip.n1*2 and ip.n3 ~= ip.n2*2 and ip.n4 ~= ip.n3*2)
		then
			--[[for key, value in pairs(ip) do
				-------TESTING
				LogToFile_AngerAnd2T1("   ip "..value)
				-------TESTING

				--check if there ip > 255 and < 0
				if value > 0 or value < 255 then
					--compare each ip sub value with "possible_imaginated_ip" ip
					for key2, possibility in pairs(possible_imaginated_ip) do
						if value == possibility then
							ip_spoof = true
							-------TESTING
							LogToFile_AngerAnd2T1("ip_spoof1")
							-------TESTING
							break;
						end
					end
				else
					ip_spoof = true
					-------TESTING
					LogToFile_AngerAnd2T1("ip_spoof2")
					-------TESTING
					break;
				end
			end]]

			for key2, possibility in pairs(possible_imaginated_ip_multiple_param) do
				if ip.n1 == possibility[1] and ip.n2 == possibility[2] and ip.n3 == possibility[3] and ip.n4 == possibility[4] then
					ip_spoof = true
					-------TESTING
					--LogToFile_AngerAnd2T1("ip_spoof3")
					-------TESTING
					break;
				end
			end
		else
			ip_spoof = true
			-------TESTING
			--LogToFile_AngerAnd2T1("ip_spoof4")
			-------TESTING
		end
	end
	
	if User_settings["Anger_Modder_detection_State"] then
		-------TESTING
		--LogToFile_AngerAnd2T1("modder detect active")
		-------TESTING
		if name_spoof and User_settings["Anger_NAME_Spoof_detection_State"] and
		 ((player.is_player_friend(pid) and User_settings["Anger_NAME_Spoof_detection_FriendState"]) 
		 or (player.player_id() == pid and User_settings["Anger_NAME_Spoof_detection_SelfState"])
		 or (User_settings["Anger_NAME_Spoof_detection_State"]))
		then
			if User_settings["Anger_NAME_Spoof_detection_Logging"] then
				AngerFunctions.LogToFile_AngerAnd2T1(name.." is spoofing his name.")
			end
			if User_settings["Anger_NAME_Spoof_detection_Notification"] then
				AngerFunctions.Anger_notify(name.." is spoofing his name.", AngerFunctions.RGBA_to_int32_t(255,255,0), 10)
			end
			if User_settings["Anger_NAME_Spoof_detection_SaveModder"] then
				AngerFunctions.save_modders_to_file(pid, "Ang-NAME_Spoof")
			end
			if User_settings["Anger_NAME_Spoof_detection_MarkModder"] then
				player.set_player_as_modder(pid, modder_flags["Ang-NAME_Spoof"])
			end
		end

		if scid_spoof and User_settings["Anger_RID_Spoof_detection_State"] and
		 ((player.is_player_friend(pid) and User_settings["Anger_RID_Spoof_detection_FriendState"]) 
		 or (player.player_id() == pid and User_settings["Anger_RID_Spoof_detection_SelfState"])
		 or (User_settings["Anger_RID_Spoof_detection_State"]))
	    then
			if User_settings["Anger_RID_Spoof_detection_Logging"] then
				AngerFunctions.LogToFile_AngerAnd2T1(name.." is spoofing his SCID to : "..scid)
			end
			if User_settings["Anger_RID_Spoof_detection_Notification"] then
				AngerFunctions.Anger_notify(name.." is spoofing his SCID to : "..scid, AngerFunctions.RGBA_to_int32_t(255,255,0), 10)
			end
			if User_settings["Anger_RID_Spoof_detection_SaveModder"] then
				AngerFunctions.save_modders_to_file(pid, "Ang-SCID_Spoof")
			end
			if User_settings["Anger_RID_Spoof_detection_MarkModder"] then
				player.set_player_as_modder(pid, modder_flags["Ang-SCID_Spoof"])
			end
		end

		if ip_spoof and User_settings["Anger_IP_Spoof_detection_State"] and
		 ((player.is_player_friend(pid) and User_settings["Anger_IP_Spoof_detection_FriendState"]) 
		 or (player.player_id() == pid and User_settings["Anger_IP_Spoof_detection_SelfState"])
		 or (User_settings["Anger_IP_Spoof_detection_State"]))
	    then
			if User_settings["Anger_IP_Spoof_detection_Logging"] then
				AngerFunctions.LogToFile_AngerAnd2T1(name.." is spoofing his IP to : "..str_ip.." ("..int_ip..")")
			end
			if User_settings["Anger_IP_Spoof_detection_Notification"] then
				AngerFunctions.Anger_notify(name.." is spoofing his IP to : "..str_ip.." ("..int_ip..")", AngerFunctions.RGBA_to_int32_t(255,255,0), 10)
			end
			if User_settings["Anger_IP_Spoof_detection_SaveModder"] then
				AngerFunctions.save_modders_to_file(pid, "Ang-IP_Spoof")
			end
			if User_settings["Anger_IP_Spoof_detection_MarkModder"] then
				player.set_player_as_modder(pid, modder_flags["Ang-IP_Spoof"])
			end
		end

		if ht_spoof and User_settings["Anger_HOST_TOKEN_Spoof_detection_State"] and
		 ((player.is_player_friend(pid) and User_settings["Anger_HOST_TOKEN_Spoof_detection_FriendState"]) 
		 or (player.player_id() == pid and User_settings["Anger_HOST_TOKEN_Spoof_detection_SelfState"])
		 or (User_settings["Anger_HOST_TOKEN_Spoof_detection_State"]))
	    then
			if User_settings["Anger_HOST_TOKEN_Spoof_detection_Logging"] then
				AngerFunctions.LogToFile_AngerAnd2T1(name.." is spoofing his HOST_TOKEN to : "..strhex_ht.." ("..int_host_token..")")
			end
			if User_settings["Anger_HOST_TOKEN_Spoof_detection_Notification"] then
				AngerFunctions.Anger_notify(name.." is spoofing his HOST_TOKEN to : "..strhex_ht.." ("..int_host_token..")", AngerFunctions.RGBA_to_int32_t(255,255,0), 10)
			end
			if User_settings["Anger_HOST_TOKEN_Spoof_detection_SaveModder"] then
				AngerFunctions.save_modders_to_file(pid, "Ang-HOST_Spoof")
			end
			if User_settings["Anger_HOST_TOKEN_Spoof_detection_MarkModder"] then
				player.set_player_as_modder(pid, modder_flags["Ang-HOST_Spoof"])
			end
		end
	end

	--if needed
	return name_spoof, scid_spoof, ip_spoof, ht_spoof
end



--speed in m/s is : speed_pid_2D_only(pid)* 1000
--underestimate by 10-25% for gta map with yield (0) 
--overestimate by Xx% for gta wwhen yield (10-100)
function AngerFunctions.speed_pid_2D_only(pid)
	local time1 = utils.time_ms()
	local coord1 = player.get_player_coords(pid)
	if network.is_session_started() and player.is_player_valid(pid) then
		if pid ~= nil and type(pid) == "number" then
			system.yield(0)
			local coord2 = player.get_player_coords(pid)
			local time2 = utils.time_ms()
			local speed =  AngerFunctions.dist_2_point_in_2D_only(coord1, coord2) / (time2-time1)
			-------TESTING
			--LogToFile_AngerAnd2T1(tostring(coord1)..":"..tostring(coord2).."/"..tostring(time2-time1))
			--LogToFile_AngerAnd2T1(tostring(dist_2_point_in_2D_only(coord1, coord2)).."/"..tostring(time2-time1))
			-------TESTING

			if tostring(speed) == "-nan(ind)" or speed > 3000 then
				-------TESTING
				--LogToFile_AngerAnd2T1("null")
				-------TESTING
				speed = 0
			end
			
			return (speed * 1000)  --*1000 ==> m/s
		else
			AngerFunctions.LogErrors("[ERROR:speed_pid_2D_only]: \"pid\" bad type or nil : "..
			"== >>> pid = "..tostring(pid)..";")
			
			return ERROR
		end
	end
end

local lsia_quad_a = v2(-1600, -2700)
local lsia_quad_b = v2(-700, -3100)
local lsia_quad_c = v2(-1000, -3650)
local lsia_quad_d = v2(-2000, -3100)
local lsia_quad_z_max_altitude = 0
local lsia_quad_z_min_altitude = -90
local casino_quad_a = v2(1170, 283)
local casino_quad_b = v2(977, -20)
local casino_quad_c = v2(906, 15)
local casino_quad_d = v2(1064, 256)
local casino_quad_z_max_altitude = 50
local casino_quad_z_min_altitude = -90
local la_mesa_vehicle_warehouse_quad_a = v2(1010, -1857)
local la_mesa_vehicle_warehouse_quad_b = v2(989, -1865)
local la_mesa_vehicle_warehouse_quad_c = v2(989, -1850)
local la_mesa_vehicle_warehouse_quad_d = v2(1010, -1852)
local la_mesa_vehicle_warehouse_quad_z_max_altitude = 35
local la_mesa_vehicle_warehouse_quad_z_min_altitude = 20
local kosatka_interior_quad_a = v2(1555, 366)
local kosatka_interior_quad_b = v2(1566, 449)
local kosatka_interior_quad_c = v2(1566, 425)
local kosatka_interior_quad_d = v2(1555, 445)
local kosatka_interior_quad_z_max_altitude = -45
local kosatka_interior_quad_z_min_altitude = -60

function AngerFunctions.is_player_in_area_considered_as_NOT_outside(pid)
	
	local pos = player.get_player_coords(pid)
	local dist = AngerFunctions.dist_2_point_in_2D_only(player.get_player_coords(pid), player.get_player_coords(player.player_id()))
	--had false detect at cargo port (forgot to check z)
	--& check if player.height is different from -180 & -190 (not -50 it is detected from outside)
	--(good for now since not quadrilatere checking below z=-90)
	if (pos.x > 4100 and pos.y < -4100)
	 or AngerFunctions.is_point_in_quadrilatere_3D_only(pos, lsia_quad_a, lsia_quad_b, lsia_quad_c, lsia_quad_d, lsia_quad_z_max_altitude, lsia_quad_z_min_altitude)
	 or AngerFunctions.is_point_in_quadrilatere_3D_only(pos, casino_quad_a, casino_quad_b, casino_quad_c, casino_quad_d, casino_quad_z_max_altitude, casino_quad_z_min_altitude)
	 or AngerFunctions.is_point_in_quadrilatere_3D_only(pos, la_mesa_vehicle_warehouse_quad_a, la_mesa_vehicle_warehouse_quad_b, la_mesa_vehicle_warehouse_quad_c, 
										la_mesa_vehicle_warehouse_quad_d, la_mesa_vehicle_warehouse_quad_z_max_altitude, 
										la_mesa_vehicle_warehouse_quad_z_min_altitude)
	 or AngerFunctions.is_point_in_quadrilatere_3D_only(pos, kosatka_interior_quad_a, kosatka_interior_quad_b, kosatka_interior_quad_c, 
										kosatka_interior_quad_d, kosatka_interior_quad_z_max_altitude, 
										kosatka_interior_quad_z_min_altitude)
	then
		-----TESTING
		--LogToFile_AngerAnd2T1(tostring(player.get_player_name(pid)).." is in not allowed area")
		-----TESTING
		return true
	else 
		
		-----TESTING
		--LogToFile_AngerAnd2T1(tostring(player.get_player_name(pid)).." is in allowed area")
		-----TESTING

		return false
	end
end

local array_AI_task_ids_telling_ped_loadingETC = {
	[1] = "CTaskPlayerIdles",
	[2] = "CTaskSynchronizedScene",
	[3] = "CTaskUseScenario",
	[4] = "CTaskNMBalance",
	[5] = "CTaskUseSequence",
	[6] = "CTaskAmbientClips",
	[7] = "CTaskScriptedAnimation",
	[8] = "CTaskHandsUp"
}

local array_AI_task_ids_telling_ped_NOT_loadingETC = {
	[1] = "CTaskVehicleGun",
	[2] = "CTaskAimGunVehicleDriveBy",
	[3] = "CTaskAimGunOnFoot",
	[4] = "CTaskGun",
	[5] = "CTaskSwapWeapon",
	[6] = "CTaskFall",
	[7] = "CTaskPlayerDrive",
	[8] = "CTaskInVehicleBasic",
	[9] = "CTaskInVehicleSeatShuffle",
	[10] ="CTaskFallOver",
	[11] ="CTaskOpenVehicleDoorFromOutside",
	[12] ="CTaskNMBuoyancy",
	[13] ="CTaskReloadGun",
	[14] ="CTaskNMFlinch",
	[15] ="CTaskTurnToFaceEntityOrCoord",
	[16] ="CTaskDropDown",
	[17] ="CTaskSlopeScramble",
	[18] ="CTaskCover",
	[19] ="CTaskMotionInCover",
	[20] ="CTaskInCover", 
	[21] ="CTaskEnterCover",
	[22] ="CTaskExitVehicleSeat",
	[23] ="CTaskNMRiverRapids",
	[24] ="CTaskClimbLadder",
	[25] ="CTaskAimAndThrowProjectile",
	[26] ="CTaskVault",
	[27] ="CTaskEnterVehicle",
	[28] ="CTaskExitVehicle",
	[29] ="CTaskNMDangle",
	[30] ="CTaskGetUp",
	[31] ="CTaskFallAndGetUp",
	[32] ="CTaskParachuteObject",
}


----function to make sure you rlly are loaded in lobby / really outside (and avoid notify while loading those kind of stuff)
---@not always good for all context. Detected only if player is making a specific action
---@no loading, not interior,
function AngerFunctions.is_player_ped_really_playing(pid, pid_ped)
	
	local task_ids_telling_ped_loadingETC_TRIGGERED = false
	local task_ids_telling_ped_NOT_loadingETC_TRIGGERED = false
	local is_player_in_area_considered_as_NOT_outside_TRIGGERED = false
	if interior.get_interior_from_entity(pid_ped) == 0
	 and not entity.is_entity_dead(pid_ped)
	then 
		for i = 1, #array_AI_task_ids_telling_ped_loadingETC do
			if ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id(array_AI_task_ids_telling_ped_loadingETC[i])) then
				task_ids_telling_ped_loadingETC_TRIGGERED = true
				return false
			end

			-------TESTING 
			--LogToFile_AngerAnd2T1("loop 1 "..tostring(i))
			-------TESTING 
		end

		if not task_ids_telling_ped_loadingETC_TRIGGERED then
			for j = 1, #array_AI_task_ids_telling_ped_NOT_loadingETC do
				if ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id(array_AI_task_ids_telling_ped_NOT_loadingETC[j])) then
					task_ids_telling_ped_NOT_loadingETC_TRIGGERED = true
				end
				
				-------TESTING 
				--LogToFile_AngerAnd2T1("loop 2 "..tostring(j))
				-------TESTING 
			end
		else
			return false
		end

		if task_ids_telling_ped_NOT_loadingETC_TRIGGERED then
			if AngerFunctions.is_player_in_area_considered_as_NOT_outside(pid) then
				is_player_in_area_considered_as_NOT_outside_TRIGGERED = true
			end
		else
			return false
		end

		if task_ids_telling_ped_NOT_loadingETC_TRIGGERED and not task_ids_telling_ped_loadingETC_TRIGGERED
		 and not is_player_in_area_considered_as_NOT_outside_TRIGGERED
		then
			return true -- player is really outside / not loading
		else
			return false
		end
	else
		return false
	end

	return false
end


----function to make sure you rlly are loaded in lobby (and avoid notify while loading those kind of stuff)
function AngerFunctions.am_i_fully_loaded_in_session(avoid_waiting)
	if avoid_waiting ~= nil and type(avoid_waiting) == "boolean" then
		local test_fully_loaded = false
		
		if network.is_session_started() and gameplay.get_game_state() == 0 and avoid_waiting and player.player_id() ~= nil then
			test_fully_loaded = true
		
		elseif network.is_session_started() and gameplay.get_game_state() == 0 and not avoid_waiting and player.player_id() ~= nil then
			system.yield(30000) -- waiting 30sec you fully load in lobby (finish SWOOP_DOWN)
			test_fully_loaded = true
		end
		
		return test_fully_loaded
	else
		AngerFunctions.LogErrors("[ERROR:am_i_fully_loaded_in_session]: avoid_waiting bad type or nil == >>> avoid_waiting = "..
		tostring(avoid_waiting)..";")
		
		--force not loaded (ERROR but to avoid bugs)
		return false
	end
end


function AngerFunctions.teleport_player_vehicle_or_warn(pid, v3_coords_or_offset, str_coords_or_offset_choice, 
								bool_feedback_sms_or_chat_message, str_feedback_sms_or_chat_message_choice)
	-------TESTING 
	AngerFunctions.LogToFile_AngerAnd2T1("in teleport_player_vehicle_or_warn")
	-------TESTING 

	local vehicle = player.get_player_vehicle(pid)
	local coord

	if str_coords_or_offset_choice == "offset" then
		coord = player.get_player_coords(pid) + v3_coords_or_offset
	elseif  str_coords_or_offset_choice == "coords" then
		coord = v3_coords_or_offset
	else
		AngerFunctions.LogErrors("[ERROR:teleport_player_vehicle]: str_coords_or_offset_choice illegal (nil or bad type or bad value) == >>> str_coords_or_offset_choice = "..
					tostring(str_coords_or_offset_choice)..";")
		return;
	end

	-------TESTING 
	AngerFunctions.LogToFile_AngerAnd2T1("coord :"..tostring(coord))
	-------TESTING 

	if vehicle ~= nil and vehicle ~= 0 then
		
		-------TESTING 
		AngerFunctions.LogToFile_AngerAnd2T1("vehicle :"..tostring(vehicle))
		-------TESTING 

		AngerFunctions.request_ctrl_of_entity(vehicle, 1800)

		entity.set_entity_coords_no_offset(vehicle, coord)
	
	else
		
		-------TESTING 
		AngerFunctions.LogToFile_AngerAnd2T1("no vehicle")
		-------TESTING 

		if pid == player.player_id() then

			-------TESTING 
			AngerFunctions.LogToFile_AngerAnd2T1("me")
			-------TESTING 

			local vehicle = player.get_player_vehicle(player.get_player_from_ped(pid))
			entity.set_entity_coords_no_offset(player.get_player_ped(pid), player.get_player_coords(player.get_player_from_ped(vehicle)) + v3(0, 0, 2000))
		
		elseif bool_feedback_sms_or_chat_message == true then
			
			-------TESTING 
			AngerFunctions.LogToFile_AngerAnd2T1("bool_feedback_sms_or_chat_message == true")
			-------TESTING 

			local player_name = tostring(player.get_player_name(pid))
			if player_name == "nil" or player_name == nil then
				player_name = "Error"
			end

			if str_feedback_sms_or_chat_message_choice == "sms" then
				player.send_player_sms(pid, "[Teleport] "..tostring(player.get_player_name(pid))..", you need to get in a vehicle for this to work.") 
			elseif  str_feedback_sms_or_chat_message_choice == "chat" then
				network.send_chat_message( "[Teleport] "..tostring(player.get_player_name(pid))..", you need to get in a vehicle for this to work.", false)
			else
				AngerFunctions.LogErrors("[ERROR:teleport_player_vehicle]: str_feedback_sms_or_chat_message_choice illegal (nil or bad type or bad value) == >>> str_feedback_sms_or_chat_message_choice = "..
							tostring(str_feedback_sms_or_chat_message_choice)..";")
				return;
			end

			-------TESTING 
			AngerFunctions.LogToFile_AngerAnd2T1("bool_feedback_sms_or_chat_message == true")
			-------TESTING 

		end
	end

end












------------------------------------------   GTA  STATS / GLOBALS / SE   -------------------------------------------------


function AngerFunctions.Char_MP()
   local MP_idx = stats.stat_get_int(gameplay.get_hash_key("MPPLY_LAST_MP_CHAR"), 1)
   return (tostring("MP" ..MP_idx))
end


local SE_hashes = {
	crash = {
		[1] = {  --Script Event Crash 1     --WORKING
			eventId = 962740265,
			params = { max = 7 , [7] = 33398 }
		},
		[2] = {  --Weather Crash      --WORKING
			eventId = -2122716210,
			params = {max = 15, [1] = -1139568479, [2] = -1, [3] = 1, [5] = -1, [8] = -1, [9] = -1 }
		},
		[3] = {  --Script Event Crash 2      --WORKING
			eventId = 767605081,
			params = {max = 39, [3] = {  above = 11 }		}
		},
		[4] = {  --Script Event Crash 3      --NOT WORKING
			eventId = -1949011582,
			params = {max = 13,
			[2] = -1139568479,
			[3] = 2, 
			[4] = 1,     }
		},
		[5] = {  --Script Event Crash 4      --NOT WORKING
			eventId = -1882923979,
			params = {max = 26, [2] = {above = -10000, below = 10000}, [3] = {above = -10000, below = 10000}
					, [4] = {above = -10000, below = 10000}, [5] = {above = -10000, below = 10000}, [6] = {above = -10000, below = 10000}
					, [7] = {above = -10000, below = 10000}, [8] = {above = -10000, below = 10000}, [9] = {above = -10000, below = 10000}
					, [10] = {above = -10000, below = 10000}, [11] = {above = -10000, below = 10000}, [12] = {above = -10000, below = 10000}
					, [13] = {above = -10000, below = 10000}, [14] = {above = -10000, below = 10000}, [15] = {above = -10000, below = 10000}
					, [16] = {above = -10000, below = 10000}, [17] = {above = -10000, below = 10000}, [18] = {above = -10000, below = 10000}
					, [19] = {above = -10000, below = 10000}, [20] = {above = -10000, below = 10000}, [21] = {above = -10000, below = 10000}
					, [22] = {above = -10000, below = 10000}, [23] = {above = -10000, below = 10000}, [24] = {above = -10000, below = 10000}
					, [25] = {above = -10000, below = 10000}, [26] = {above = -10000, below = 10000}
				}
		},
		[6] = {  --Script Event Crash 5      --NOT WORKING
			eventId = -1975590661,
			params = {max = 10, [7] = { below = 0, above = 0 }--[[!=0]]		}
		},
		[7] = {  --Potential Crash      --NOT WORKING
			eventId = -1559754940,
			params = {max = 39}
		},
		[8] = {  --Untested Crash Event      --NOT WORKING
			eventId = -87967637,
			params = {max = 39}
		}
	},
	--end SE_crash
	kick = {	---IN SEP.CFG
		[1] = {  --Network bail kick --NOT WORKING
			eventId = -435067392,
			params = {max = 2, [2] = "player_global"	}
		},
		[2] = {  --Kick event 1     --WORKING
			eventId = -171207973,
			params = {max = 39, [2] = { below = 0, above = 114 }		}
		},
		[3] = {  --Kick event 2     --WORKING
			eventId = -1212832151,
			params =  {max = 39, [2] = { below = 0, above = 39 }	}
		},
		[4] = {  --Kick event 3     --WORKING
			eventId = 1317868303,
			params =  {max = 39, [3] = { below = -1 }		}
		},
		[5] = {  --Kick event 4     --WORKING
			eventId = -1054826273,
			params = {max = 39, [2] = { below = 0, above = 19 }		}
		},
		[6] = {  --Kick event 5     --WORKING
			eventId = 1620254541,
			params = {max = 39, [5] = { above = 39 }		}
		},
		[7] = {  --Kick event 6     --WORKING
			eventId = 1401831542,
			params = {max = 39, [2] = { below = 0, above = 0 }, [3] = { above = 123 }		}
		},
		[8] = {  --Kick event 7     --NOT WORKING
			eventId = -1491386500,
			params = {max = 39, [2] = { below = 0 }, [24] = "player_global"	}
		},
		[9] = {  --Kick event 8     --NOT WORKING
			eventId = -1070934291,
			params = {max = 23, [2] = "pid",
					[3] = { below = -10 },[4] = { below = -10 },[5] = { below = -10 }, 
					[6] = { below = -10 }, [7] = { below = -10 },[8] = { below = -10 }, 
					[9] = { below = -10 }, [10] = { below = -10 }, [11] = { below = -10 },
					[12] = { below = -10 },[13] = { below = -10 },[14] = { below = -10 },
					[15] = { below = -10 },[16] = { below = -10 },[17] = { below = -10 },
					[18] = { below = -10 },[19] = { below = -10 },[20] = { below = -10 },
					[21] = { below = -10 },[22] = { below = -10 },[23] = { below = -10 },		}
		},
		[10] = {  --Kick event 9.1    --WORKING
			eventId = -1949011582,
			params = {max = 13, [2] = -1726396442, [3]=1, [4]=1,
					[5] = { below = -10 }, [6] = { below = -10 }, [7] = { below = -10 },
					[8] = { below = -10 }, [9] = { below = -10 },
					[10] = "pid", [11] = { below = -1 },
					[12] = { below = -10 }, [13] = { below = -10 } }
		},
		[11] = {  --Kick event 9.2    --NOT WORKING
			eventId = -1949011582,
			params = {max = 13, [2] = 154008137, [3]=2, [4]=1,
					[5] = { below = -10 }, [6] = { below = -10 }, [7] = { below = -10 },
					[8] = { below = -10 }, [9] = { below = -10 },
					[10] = "pid", [11] = { below = -1 },
					[12] = { below = -10 }, [13] = { below = -10 } }
		},
		[12] = {  --Kick event 9.3    --WORKING
			eventId = -1949011582,
			params = {max = 13, [2] = 428882541, [3]=3, [4]=1,
					[5] = { below = -10 }, [6] = { below = -10 }, [7] = { below = -10 },
					[8] = { below = -10 }, [9] = { below = -10 },
					[10] = "pid", [11] = { below = -1 },
					[12] = { below = -10 }, [13] = { below = -10 } }
		},
		[13] = {  --Kick event 9.4    --WORKING
			eventId = -1949011582,
			params = {max = 13, [2] = -1714354434, [3]=4, [4]=1,
					[5] = { below = -10 }, [6] = { below = -10 }, [7] = { below = -10 },
					[8] = { below = -10 }, [9] = { below = -10 },
					[10] = "pid", [11] = { below = -1 },
					[12] = { below = -10 }, [13] = { below = -10 } }
		},
		[14] = {  --Indirect SH kick
			eventId = -720040631,
			params = {max = 39}
		}
	},
	--end SE_kick
	ScriptHost_kick = {	---IN SEP.CFG
		[1] = { 
			eventId = 523402757,
			params = {max = 39}
		}
	},
	ScriptHost_crash = {	---IN SEP.CFG
		[1] = {  --Script Host Crash
			eventId = -922075519,
			params = {max = 39, [4] = { below = 4, above = 4 }--[[!=4]]		}
		}
	},
	--end ScriptHost_kick
	notify = {	---IN SEP.CFG    -USELESS ??
		[1] = { --notify 1
			eventId = 523402757,
			params = {max = 39}
		},
		[2] = { --notify 2
			eventId = -1279955769,
			params = {max = 39}
		},
		[3] = { --notify ...
			eventId = 162639435,
			params =  {max = 39}
		},
		[4] = {
			eventId = 1331862851,
			params =  {max = 39}
		},
		[5] = {
			eventId = 2086111581,
			params = {max = 39}
		},
		[6] = {
			eventId = 860051171,
			params = {max = 39}
		},
		[7] = {
			eventId = -2069242129,
			params = {max = 39}
		},
		[8] = {
			eventId = -1125804155,
			params = {max = 39}
		},
		[9] = {
			eventId = -1495195128,
			params = {max = 39}
		},
		[10] = {
			eventId = 94936514,
			params = {max = 39}
		},
		[11] = { 
			eventId = -751761218,
			params = {max = 39}
		},
		[12] = { 
			eventId = 761687265,
			params = {max = 39}
		},
		[13] = { 
			eventId = 2136412382,
			params = {max = 39}
		},
		[14] = { 
			eventId = 1456429682,
			params = {max = 39}
		},
		[15] = { 
			eventId = 1503592133,
			params = {max = 39}
		},
		[16] = { 
			eventId = -487923362,
			params = {max = 39}
		}
	},
	--end SE_notify
	SH_curse = {	---IN SEP.CFG
		[1] = {     --SH Curse
			eventId = 84857178,
			params = { max = 39, [1] = 61749268 , [2] = -80053711, 
					[3] =-78045655, [4] =56341553, [5] =-78686524, 
					[6] =-46044922, [7] =-22412109, [8] =29388428, 
					[9] =-56335450}
		}
	},
	--end SH_curse
	block_passive = {	---IN SEP.CFG
		[1] = {			--WORKING
			eventId = -909357184,
			params = { max = 2, [1] = {on = 1, off = 0}, [2] = {on = 1, off = 0}}
		}
	},
	--end block_passive
	invalid_appartment_invite = {	---IN SEP.CFG 
		[1] = {				--WORKING 
			eventId = -171207973,
			params = { max = 8, [2] = "pid", [3] = 1, [4] = 0, [5] = {below = 1, above = 114}, [6] = 1, [7] = 1, [8] = 1}
		}
	},
	--end invalid_appartment_invite
	blackscreen_kick = {	---IN SEP.CFG
		[1] = {				-- BLACKSCREEN KICK ???
			eventId = -171207973,
			params = { max = 8, [3] = 1, [4] = 1, [5] = -1, [6] = 1, [7] = 1, [8] = 1}
		}
	},
	--end blackscreen
	appartment_invite = {	---IN SEP.CFG
		[1] = {			 --1 = Exclipse Towers ---- 113 = maze bank so same list as in the mod i guess
			eventId = -171207973,
			params = { max = 8, [2] = "pid", [3] = 1, [4] = 0, [5] = {input_integer = { max = 144, min = 1}} , [6] = 1, [7] = 1, [8] = 1}
		}
	},
	--end apartment_invite
	send_island = {	---IN SEP.CFG
		[1] = {				-- WORKING
			eventId = 1300962917,
			params = { max = 4, [2] = 1300962917, [3] = 0, [4] = 0}
		}
	},
	--end send_island
	force_mission = {	---IN SEP.CFG
		[1] = {				-- WORKING
			eventId = -545396442,
			params = { max = 2, [2] = { below = 8 , above = 1 }}
		},
		[2] = {				--NOT WORKING
			eventId = 1115000764,
			params = { max = 2, [2] = { below = 8 , above = 1 }}
		}
	},
	--end force_mission
	invite = {	---IN SEP.CFG
		[1] = {
			eventId = 1097312011,
			params = { max = 39}
		}
	},
	--end invite
	CEO_MC_ban = {	---IN SEP.CFG
		[1] = {				-- WORKING
			eventId = -738295409,
			params = { max = 2, [2] = 1 }
		}
	},
	--end CEO_ban
	CEO_terminate = {	---IN SEP.CFG
		[1] = {				--NOT WORKING
			eventId = -1648921703,
			params = { max = 3, [2] = 1, [3] = 6  }
		}
	},
	--end CEO_terminate
	CEO_dismiss = {	---IN SEP.CFG
		[1] = {				--NOT WORKING
			eventId = -1648921703,
			params = { max = 3, [2] = 1, [3] = 5  }
		}
	},
	--end CEO_dismiss
	rotate_cam = {	---IN SEP.CFG
		[1] = {
			eventId = 1120313136,
			params = { max = 39 }
		}
	},
	--end rotate_cam
	bribe_cop = {	---IN SEP.CFG          
		[1] = {				--WORKING 
			eventId = 392501634,
			params = { max = 6, [2] = "utils.time-60", [3] = "utils.time", [4] = "global_4624", [5] = 1, [6] = "player_global"}
		}
	},
	--end bribe_cop
	CEO_10k = {	---IN SEP.CFG
		[1] = {
			eventId = -2029779863,
			params = { max = 7, [2] = 10000, [3] = -1292453789, [4] = 0, [5] = "player_global", [6] = "global_9", [7] = "global_10" }
		},
		[2] = {
			eventId = -2029779863,
			params = { max = 7, [2] = 10000, [3] = -1292453789, [4] = 1, [5] = "player_global", [6] = "global_9", [7] = "global_10" }
		}
	},
	--end CEO_10k
	CEO_30k = {	---IN SEP.CFG
		[1] = {
			eventId = -2029779863,
			params = { max = 7, [2] = 30000, [3] = 198210293, [4] = 1, [5] = "player_global", [6] = "global_9", [7] = "global_10" }
		}
	},
	--end CEO_10k
	Modded_Spectate = {	---IN SEP.CFG
		[1] = {
			eventId = -2074614269,
			params = { max = 39 }
		}
	},
	--end Modded_Spectate
	destroy_personnal_vehicle = {	---IN SEP.CFG
		[1] = {            --WORKING : call back the vehicle to garage when the user stopped being inside it
			eventId = -1662268941,
			params = { max = 2, [2] = "pid" }
		}
	},
	--end destroy_personnal_vehicle
	vehicle_kick = {	---IN SEP.CFG
		[1] = {				--WORKING 
			eventId = -1333236192,
			params = { max = 8, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 1, [7] = "pid", [8] = "frame_count"}
		}
	},
	--end vehicle_kick
	vehicle_emp = {	---IN SEP.CFG
		[1] = {				--NOT WORKING
			eventId = -152440739,
			params = { max = 5, [2] = "player_pos_x", [3] = "player_pos_y", [4] = "player_pos_z", [5] = 0 }
		}
	},
	--end vehicle_emp
	disable_jumping = {	---IN SEP.CFG
		[1] = {
			eventId = -152440739,
			params = { max = 8--[[maybe 8]], [2]=31, [3]=0, [4]=0, [5]=0, [6]=0, [7]=0, [8]=0 }
		}
	},
	--end disable_jumping
	transaction_failed = {	---IN SEP.CFG  
		[1] = {			--WORKING
			eventId = 1302185744,
			params = { max = 8, [2] = 50000, [3] = 0, [4] = 1, [5] = "player_global", [6] = "global_9", [7] = "global_10", [8] = 1 }
		}
	},
	--end transaction_failed
	show_banner = {	---IN SEP.CFG
		[1] = {
			eventId = 639032041,
			params = { max = 9, [2]= 8,[3] = 906126866, [4] = 702, [5] = 18, 
						[6] = 0, [7]=0, [8]=0xFFFFFFFF, [9]=0xFFFFFFFF}
		},
		[2] = {
			eventId = 639032041,
			params = { max = 9, [2]= 28,[3] = 1212369083, [4] = 692, [5] = 17, 
						[6] = 0, [7]=0, [8]=0xFFFFFFFF, [9]=0xFFFFFFFF}
		}
	},
	--end show_banner
	bounty = {	---IN SEP.CFG
		[1] = {			--WORKING
			eventId = -116602735,
			params = { max = 21, [2] = "player_target", [3] = 3, [4] = {input_integer = { max = 10000, min = 0}},
					[5] = 1, [6] = 0 --[[anonymous]], [7] = 0, [8] = 0, [9] = 0, [10] = 0, 
					[11] = 0, [12] = 0, [13] = 0, [14] = 0, [15] = 0, [16] = 0, [17] = 0, [18] = 0,
					[19] = 0, [20] = "global_9", [21] = "global_10"}
		}
	},
	--end bounty
	anonymous_bounty = {	---IN SEP.CFG : 0xf90cc891
		[1] = {			--WORKING
			eventId = -116602735,
			params = { max = 21, [2] = "player_target", [3] = 3, [4] = {input_integer = { max = 10000, min = 0}},
					[5] = 1, [6] = 1 --[[anonymous]], [7] = 0, [8] = 0, [9] = 0, [10] = 0, 
					[11] = 0, [12] = 0, [13] = 0, [14] = 0, [15] = 0, [16] = 0, [17] = 0, [18] = 0,
					[19] = 0, [20] = "global_9", [21] = "global_10"}
		}
	},
	--end anonymous_bounty
	sound_spam_1 = {	---IN SEP.CFG
		[1] = {
			eventId = 1097312011,
			params = { max = 39 }
		}
	},
	--end sound_spam_1
	sound_spam_2 = {	---IN SEP.CFG
		[1] = {
			eventId = -1162153263,
			params = { max = 39 }
		}
	},
	--end sound_spam_2
	mc_kick = {	---IN SEP.CFG
		[1] = {
			eventId = -2105858993,
			params = { max = 39 }
		}
	},
	--end mc_kick
	off_radar = {	---IN SEP.CFG
		[1] = {			--WORKING
			eventId = 575518757,
			params = { max = 6, [2] = "utils.time-60", [3] = "utils.time", [4] = 1, [5] = 1, [6] = "player_global" }
		}
	},
	--end off_radar
	clear_cop = {	---IN SEP.CFG
		[1] = {			--WORKING
			eventId = 393068387,
			params = { max = 2, [2] = "player_global" }
		}
	},
	--end clear_cop
	insurance_fraud = {	---IN SEP.CFG
		[1] = {			--WORKING
			eventId = 891272013,
			params = { max = 2 --[[2: is math.random(-min, +max)]] }
		}
	},
	--end insurance_fraud
	imp_detection = {	---IN SEP.CFG
		[1] = {
			eventId = 1120313136,
			params = { max = 39, [2] = 1289518925, [3] = 9373, [4] = 0, [5] = 177 }
		}
	},
	--end imp_detection
	testy = {	---IN SEP.CFG
		[1] = {
			eventId = -1846290480,
			params = { max = 3, [2] = 0, [3] = 6514}
		}
	}
	--end test
}

--(1630317 + (1 + (pid * 595) + 506))
local global_players_data_offset = 1893548
local global_player_number_of_data = 600
local desired_data_for_trigger_SE_offset = 511

--1921036 + 9/10
local some_global_data_offset1 = 1921036
local desired_data_from_global_data_offset1_9 = 9
local desired_data_from_global_data_offset1_10 = 10

--2540384 + 4624
local some_global_data_offset2 = 2540384
local desired_data_from_global_data_offset2_4624 = 4624

function AngerFunctions.get_player_global_for_TSE(pid)
	return script.get_global_i(global_players_data_offset + (1 + (pid * global_player_number_of_data) + desired_data_for_trigger_SE_offset))
end

function AngerFunctions.get_global_data_9_for_TSE()
	return script.get_global_i(some_global_data_offset1 + desired_data_from_global_data_offset1_9)
end

function AngerFunctions.get_global_data_10_for_TSE()
	return script.get_global_i(some_global_data_offset1 + desired_data_from_global_data_offset1_10)
end


function AngerFunctions.get_global_data_4624_for_TSE()
	return script.get_global_i(some_global_data_offset2 + desired_data_from_global_data_offset2_4624)
end

function AngerFunctions.fill_params_adequatly(pid, params, value, target_pid)

	for i = 2 --[[1 is pid]], params.max do
		if params[i] ~= nil then
			if type(params[i]) == "number" then
				--do nothing it's already what we want it to be
			elseif type(params[i]) == "string" then
				
				if params[i] == "pid" and pid ~= nil and type(pid) == "number" then
					params[i] = tonumber(pid)
				elseif params[i] == "player_global" and pid ~= nil and type(pid) == "number"  then
					params[i] = tonumber(AngerFunctions.get_player_global_for_TSE(pid))
				elseif params[i] == "global_9" then
					params[i] = tonumber(AngerFunctions.get_global_data_9_for_TSE())
				elseif params[i] == "global_10" then
					params[i] = tonumber(AngerFunctions.get_global_data_10_for_TSE())
				elseif params[i] == "global_4624" then
					params[i] = tonumber(AngerFunctions.get_global_data_4624_for_TSE())
				elseif params[i] == "frame_count" then
					params[i] = tonumber(gameplay.get_frame_count())
				elseif params[i] == "utils.time" then
					params[i] = tonumber(utils.time())
				elseif params[i] == "utils.time-60" then
					params[i] = tonumber(utils.time()-60)
				elseif params[i] == "player_pos_x" and pid ~= nil and type(pid) == "number" then
					params[i] = tonumber(AngerFunctions.float_round_to_integer(player.get_player_coords(pid).x))
				elseif params[i] == "player_pos_y" and pid ~= nil and type(pid) == "number" then
					params[i] = tonumber(AngerFunctions.float_round_to_integer(player.get_player_coords(pid).y))
				elseif params[i] == "player_pos_z" and pid ~= nil and type(pid) == "number" then
					local a, temp = gameplay.get_ground_z(player.get_player_coords(pid))
					params[i] = tonumber(AngerFunctions.float_round_to_integer(temp + 0.6))
				elseif params[i] == "player_target" and target_pid ~= nil and type(target_pid) == "number" then
					params[i] = tonumber(target_pid)
				end

				--if still a string as it is supposed to be a number
				if type(params[i]) == "string" then
					params[i] = math.random(--[[0x80000000]]-2147483648, --[[0x7FFFFFFF]]2147483647)
				end

			elseif type(params[i]) == "table" then

				if params[i].input_integer ~= nil  and type(value) == "number"
				 and type(params[i].input_integer) == "table"
			   	then
					if value <= params[i].input_integer.max and value >= params[i].input_integer.min then
						params[i] =  value
					elseif value == false then
						params[i] =  math.random(params[i].input_integer.min, params[i].input_integer.max)
					end

				elseif params[i].on ~= nil and params[i].off ~= nil
				 and type(params[i].on) == "number" and type(params[i].off) == "number"
				 and value ~= nil and type(value) == "boolean"
			   	then
					if value == true then
						params[i] =  params[i].on
					elseif value == false then
						params[i] =  params[i].off
					end

				elseif params[i].choice_i_min ~= nil and params[i].choice_i_max ~= nil
				 and type(params[i].choice_i_min) == "number" and type(params[i].choice_i_max) == "number"
				 and value ~= nil and type(value) == "number"
				then
				   
					if value > params[i].choice_i_min and value < params[i].choice_i_max then
					   	params[i] =  value
				    elseif value == false then
					   	return INVALID_RANGE
				    end
				
				elseif params[i].above ~= nil and params[i].below ~= nil
				 and type(params[i].below) == "number" and type(params[i].above) == "number"
				then
					-------TESTING
						--LogToFile_AngerAnd2T1("below["..tostring(i).."]: "..tostring(params[i].below).."above["..tostring(i).."]: "..tostring(params[i].above))
					-------TESTING

					--if above & below are equals (aka the params should never be this number for the ven to work)
					if params[i].above == params[i].below then
						-------TESTING
						--LogToFile_AngerAnd2T1("below == above")
						-------TESTING
						if math.random(0, 1) == 1 then
							--if above random result == 1 (true) we take the range : [params[i].above+1 to max.integer]
							params[i] = math.random(params[i].above--[[this_number]]  +1  , --[[0x7FFFFFFF]]2147483647)
						else
							--if above random result == 0 (false) we take the range : [min.integer to params[i].below-1]
							params[i] = math.random(--[[0x80000000]]-2147483648, params[i].below--[[this_number]]  -1  )
						end
					--if we have a range exclusion for this params[i] (take_everything_above_this_number > take_everything_below_this_number)
					elseif params[i].above > params[i].below then
						-------TESTING
						--LogToFile_AngerAnd2T1("above > below")
						-------TESTING
						if math.random(0, 1) == 1 then
							--if above random result == 1 (true) we take the range : [params[i].above to max.integer]
							params[i] = math.random(params[i].above--[[this_number]]+1, --[[0x7FFFFFFF]]2147483647)
						else
							--if above random result == 0 (false) we take the range : [min.integer to params[i].below]
							params[i] = math.random(--[[0x80000000]]-2147483648, params[i].below-1)
						end

					--if we are looking for a value in this range (take_everything_above_this_number < take_everything_below_this_number)
					elseif params[i].above < params[i].below then
						-------TESTING
						--LogToFile_AngerAnd2T1("above < below")
						-------TESTING
						params[i] = math.random(params[i].above--[[this_number]], params[i].below--[[this_number]])
					
					--if the system had problem of any kind or no declared value
					else
						params[i] = math.random(--[[0x80000000]]-2147483648, --[[0x7FFFFFFF]]2147483647)
					end



				--else if we have a below but no above
				elseif params[i].above == nil and params[i].below ~= nil and type(params[i].below) == "number" then
					-------TESTING
					--LogToFile_AngerAnd2T1("above == nil; below != nil")
					-------TESTING
					params[i] = math.random(--[[0x80000000]]-2147483648, params[i].below--[[this_number]])

				--else if we have a above but no below
				elseif params[i].above ~= nil and params[i].below == nil and type(params[i].above) == "number" then
					-------TESTING
					--LogToFile_AngerAnd2T1("above != nil; below == nil")
					-------TESTING
					params[i] = math.random(params[i].above--[[this_number]], --[[0x7FFFFFFF]]2147483647)
				
				--if the system had problem of any kind
				else
					params[i] = math.random(--[[0x80000000]]-2147483648, --[[0x7FFFFFFF]]2147483647)
				end

			--if the system had problem of any kind
			else
				params[i] = math.random(--[[0x80000000]]-2147483648, --[[0x7FFFFFFF]]2147483647)
			end
		else
			params[i] = math.random(--[[0x80000000]]-2147483648, --[[0x7FFFFFFF]]2147483647)
		end

		-------TESTING
		--LogToFile_AngerAnd2T1("params["..tostring(i).."]: "..tostring(params[i]))
		-------TESTING
		
	end

	return params
end


function AngerFunctions.send_SE(pid, table_hash, value, target_pid)
	--prevent losing data at any stage after
	local table_hash_copy = table_hash

	if table_hash_copy[1] == nil or type(table_hash_copy[1]) ~= "table" then
		-------TESTING
		--LogToFile_AngerAnd2T1("specific SE called")
		-------TESTING

		--if the param[1], supposed to take the pid is already filled by the declaration (aka don't put the pid at index 1)
		if table_hash_copy.params[1] == nil or type(table_hash_copy.params[1]) ~= "number" then
			table_hash_copy.params[1] = pid
		end
		
		table_hash_copy.params = AngerFunctions.fill_params_adequatly(pid, table_hash_copy.params, value, target_pid)--, table_hash_copy.params)
		
		-------TESTING
		--for key, value in pairs(table_hash_copy.params) do
		--	LogToFile_AngerAnd2T1("param["..tostring(key).."]: "..tostring(value))
		--end
		-------TESTING

		script.trigger_script_event(table_hash_copy.eventId, pid, table_hash_copy.params)

	else --if we call a group of SE

		-------TESTING
		--LogToFile_AngerAnd2T1("group SE called")
		-------TESTING

		for i = 1 , #table_hash_copy do
			-------TESTING
			--LogToFile_AngerAnd2T1("test SE :"..tostring(i))
			-------TESTING
			if table_hash_copy[i].eventId ~= nil
			and table_hash_copy[i].params ~= nil
			then
				--if the param[1], supposed to take the pid is already filled by the declaration (aka don't put the pid at index 1)
				if table_hash_copy[i].params[1] == nil or type(table_hash_copy[i].params[1]) ~= "number" then
					table_hash_copy[i].params[1] = pid
				end
				
				table_hash_copy[i].params = AngerFunctions.fill_params_adequatly(pid, table_hash_copy[i].params, value, target_pid)--, table_hash_copy.params)
				
				-------TESTING
				--for key, value in pairs(table_hash_copy[i].params) do
				--	LogToFile_AngerAnd2T1("param["..tostring(i).."]["..tostring(key).."]: "..tostring(value))
				--end
				-------TESTING

				script.trigger_script_event(table_hash_copy[i].eventId, pid, table_hash_copy[i].params)
			end
		end
	end
end






--[[/***************************** SLOW THREAD **********************************************/]]
function AngerFunctions.slow_thread()
	
	while true do
		
		-------------Max Mental State study
		if User_settings["Max_MentalState_State"] == true then
			if type(User_settings["Max_MentalState_value"]) == "number" and User_settings["Max_MentalState_value"] >= 0
			 and User_settings["Max_MentalState_value"] <= 100
			then
				local range_of_protection = 2

				if stats.stat_get_float(gameplay.get_hash_key(AngerFunctions.Char_MP().."_PLAYER_MENTAL_STATE"), 0) > User_settings["Max_MentalState_value"] + range_of_protection
				 or stats.stat_get_float(gameplay.get_hash_key(AngerFunctions.Char_MP().."_PLAYER_MENTAL_STATE"), 0) > (100 - range_of_protection)
				then
					local purcent_10 = User_settings["Max_MentalState_value"] * 0.1
					stats.stat_set_float(gameplay.get_hash_key(AngerFunctions.Char_MP().."_PLAYER_MENTAL_STATE"), 
										 AngerFunctions.float_round_to_integer(User_settings["Max_MentalState_value"] - purcent_10))
				end

			else
				AngerFunctions.LogErrors("[ERROR:slow_thread]: Max_MentalState_value: bad type or value == >>> Max_MentalState_value = "..
				tostring(User_settings["Max_MentalState_value"])..";")
			end
		end
		
		
		
		
		-------------------------------

		


		-------------join time out scan to be able to not make redundancy on the file blacklist.cfg
		
		
		
		
		-------------------------------
		
		
		
		
		------------ scan default profile file to have menu position, size, etc ...
		
		
		
		
		-------------------------------
	
	
		system.yield(5000) --5s Avoid freezes, pause the thread for XXX ms and resume
	end
end







--[[/***************************** EVENT LISTENING THREAD(S) / FUNCTIONS **********************************************/]]
local event_listener_id = {}   --at index "player_join" is joining_player , at index "player_leave" is leaving_player ,at "chat" is chat_event
local all_player_data = {}

function AngerFunctions.save_joining_player(pid, name, scid, int_ip, host_token_dec)
	if pid ~= nil and name ~= nil and scid ~= nil and int_ip ~= nil and host_token_dec ~= nil 
	 and type(pid) == "number" and type(name) == "string" and type(scid) == "number" and type(int_ip) == "number"
	 and type(host_token_dec) == "number"
	then
		all_player_data[pid]=
		{
			["name"] = name,
			["scid"] = scid,
			["int_ip"] = int_ip,
			["host_token_dec"] = host_token_dec,
			["is_session_host"] = false,
			["is_script_host"] = false,
			["is_leaving_player_process_done"] = false
		}
		if pid == script.get_host_of_this_script() then
			all_player_data[pid]["is_script_host"] = true
		end
		if player.get_host() == pid then
			all_player_data[pid]["is_session_host"] = true
		end
		
		return SUCCESS
	else
		AngerFunctions.LogErrors("[ERROR:save_joining_player]: parameter: bad type or nil == >>> pid = "..
		tostring(pid).."; name = "..tostring(name).."; scid = "..tostring(scid).."; int_ip = "..tostring(int_ip)..
		"; host_token_dec = "..tostring(host_token_dec)..";")
		
		return ERROR
	end
end

function AngerFunctions.save_modders_to_file(pid, string_modder_flag)
	
	AngerFunctions.SaveModders(tostring(all_player_data[pid]["name"]).." | "..
				tostring(all_player_data[pid]["scid"]).." | "..
				tostring(AngerFunctions.intIP_to_strIP(all_player_data[pid]["int_ip"])).." | "..
				tostring(all_player_data[pid]["int_ip"]).." | "..
				tostring(AngerFunctions.dec_to_hex_UPPER(all_player_data[pid]["host_token_dec"])).." | "..
				tostring(all_player_data[pid]["host_token_dec"])..
				" : was detected for "..string_modder_flag)
		
end

--function here in case of lua script reset/loading in middle of a lobby or to avoid bug in all_player_data
function AngerFunctions.thread_check_all_player_data_content()
	local start_up = true
	
	while true do
		if network.is_session_started() and player.player_id() ~= nil and type(player.player_id()) == "number"
		 --and all_player_data ~= nil and type(all_player_data) == "table"
		then
			
			for pid=0,31 do
				--if player is in lobby and the saved_guy at his pid is NOT empty and exist with data
				if player.is_player_playing(pid) and player.get_player_name(pid) ~= nil 
				 and type(player.get_player_name(pid)) == "string" and all_player_data[pid] ~= nil 
				 and type(all_player_data[pid]) == "table"
				then
					--if the player at his pid is NOT the one with saved data, we save the player as if he was a joining_player
					if not all_player_data[pid]["name"] == player.get_player_name(pid) or not all_player_data[pid]["scid"] == player.get_player_scid(pid)
					 or not all_player_data[pid]["int_ip"] == player.get_player_ip(pid) or not all_player_data[pid]["host_token_dec"] == player.get_player_host_token(pid)
					then
						AngerFunctions.save_joining_player(pid, player.get_player_name(pid), player.get_player_scid(pid), player.get_player_ip(pid), player.get_player_host_token(pid))
						
						if utils.time_ms() - START_UP_TIME_MS > 2000 then
							AngerFunctions.LogToFile_AngerAnd2T1(tostring(player.get_player_name(pid)).." | "..tostring(player.get_player_scid(pid)).." | "..
							tostring(AngerFunctions.intIP_to_strIP(player.get_player_ip(pid))).." | "..tostring(AngerFunctions.dec_to_hex_UPPER(player.get_player_host_token(pid)))..
							" : is joining")
						end

						AngerFunctions.scan_for_spoofing(pid, player.get_player_name(pid), player.get_player_scid(pid), 
									player.get_player_ip(pid), player.get_player_host_token(pid))
						
					end
				--if player is in lobby and the saved_guy at his pid IS empty exist NO data
				elseif player.is_player_playing(pid) and player.get_player_name(pid) ~= nil 
				 and type(player.get_player_name(pid)) == "string" and all_player_data[pid] == nil 
				then
					AngerFunctions.save_joining_player(pid, player.get_player_name(pid), player.get_player_scid(pid), player.get_player_ip(pid), player.get_player_host_token(pid))
					
					if utils.time_ms() - START_UP_TIME_MS > 2000 then
						AngerFunctions.LogToFile_AngerAnd2T1(tostring(player.get_player_name(pid)).." | "..tostring(player.get_player_scid(pid)).." | "..
						tostring(AngerFunctions.intIP_to_strIP(player.get_player_ip(pid))).." | "..tostring(AngerFunctions.dec_to_hex_UPPER(player.get_player_host_token(pid)))..
						" : is joining")
					end

					AngerFunctions.scan_for_spoofing(pid, player.get_player_name(pid), player.get_player_scid(pid), 
									player.get_player_ip(pid), player.get_player_host_token(pid))

				elseif not player.is_player_playing(pid) and player.get_player_name(pid) == nil 
				then
					if all_player_data[pid] ~= nil and type(all_player_data[pid]) == "table" then
						if all_player_data[pid]["is_leaving_player_process_done"] == true then
							all_player_data[pid] = nil
						end
					end
				end
			end
			
			
			if start_up == true then
			
				while player.get_host() == nil or type(player.get_host()) ~= "number" 
				 or script.get_host_of_this_script() == nil or type(script.get_host_of_this_script()) ~= "number" do
					--do nothing just wait someone is host
					system.yield(0)
				end
				
				if player.get_host() ~= nil and type(player.get_host()) == "number"
				 --NOT WORKING : and all_player_data[player.get_host()]["is_session_host"] == false or all_player_data[player.get_host()]["is_session_host"] == nil
				then
					if player.get_host() ~= player.player_id() then
						AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(player.get_host()).." is the Session Host")
												
						if all_player_data[player.get_host()] ~= nil and type(all_player_data[player.get_host()]) == "table"
						then
							all_player_data[player.get_host()]["is_session_host"] = true
						end
						
					else 
						AngerFunctions.LogToFile_AngerAnd2T1("You are the Session Host")
												
						if all_player_data[player.get_host()] ~= nil and type(all_player_data[player.get_host()]) == "table"
						then
							all_player_data[player.get_host()]["is_session_host"] = true
						end
					end
				end
				
				if script.get_host_of_this_script() ~= nil and type(script.get_host_of_this_script()) == "number"
				 --NOT WORKING : and not all_player_data[script.get_host_of_this_script()]["is_script_host"]
				then
					if script.get_host_of_this_script() ~= player.player_id() then
						AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(script.get_host_of_this_script()).." is the Script Host")
						
						if all_player_data[script.get_host_of_this_script()] ~= nil and type(all_player_data[script.get_host_of_this_script()]) == "table"
						then
							all_player_data[script.get_host_of_this_script()]["is_script_host"] = true
						end
						
					else 
						AngerFunctions.LogToFile_AngerAnd2T1("You are the Script Host")
						
						if all_player_data[script.get_host_of_this_script()] ~= nil and type(all_player_data[script.get_host_of_this_script()]) == "table"
						then						
							all_player_data[script.get_host_of_this_script()]["is_script_host"] = true
						end
					end
					
				end
				
			start_up = false
			end
		end
		
		system.yield(300)
	end
end




function AngerFunctions.thread_Exit_Event_Listening()
	
	event_listener_id["exit"] = event.add_event_listener("exit", function(event)
			
		AngerFunctions.LogToFile_AngerAnd2T1("Bye ! Hope you enjoyed playing with Anger Features "..Anger_loaded_version)
	end)
end


--maybe delete fuction here
function AngerFunctions.thread_Join_Event_listening()
	
	--event.remove_event_listener("player_join", event_listener_id[0])        --if needed
	event_listener_id["player_join"] = event.add_event_listener("player_join", function(event)
		local joining_player = event.player
		local start_time = utils.time_ms()
			
			while (not player.get_player_scid(joining_player) or type(player.get_player_scid(joining_player)) ~= "number"  
			 or not player.get_player_host_token(joining_player) or type(player.get_player_host_token(joining_player)) ~= "number"  
			 or not player.get_player_ip(joining_player) or type(player.get_player_ip(joining_player)) ~= "number"
			 or not player.get_player_name(joining_player) or type(player.get_player_name(joining_player)) ~= "string"
			 or not player.is_player_valid(joining_player)) 
			  and utils.time_ms() - start_time < 1000
			do
				system.yield(50)
				--nothing just wait they appear
			end

			--if we had an error of any kind with parameters (timer overflow will occur due to while)
			if (utils.time_ms() - start_time > 1000) then
			else
				AngerFunctions.LogErrors("[ERROR:thread_Join_Event_listening]: parameter: bad type or nil or timer overflow == >>> scid(joining_player) = "..
				tostring(player.get_player_scid(joining_player))..
				"; host_token(joining_player) = "..tostring(player.get_player_host_token(joining_player))..
				"; ip(joining_player) = "..tostring(player.get_player_ip(joining_player))..
				"; name(joining_player) = "..tostring(player.get_player_name(joining_player))..
				"; timer = "..tostring(utils.time_ms() - start_time)..";")
			end
			
			AngerFunctions.save_joining_player(joining_player, player.get_player_name(joining_player),
								player.get_player_scid(joining_player), player.get_player_ip(joining_player), player.get_player_host_token(joining_player))
			
			AngerFunctions.LogToFile_AngerAnd2T1(tostring(player.get_player_name(joining_player)).." | "..tostring(player.get_player_scid(joining_player)).." | "..
									tostring(AngerFunctions.intIP_to_strIP(player.get_player_ip(joining_player))).." | "..tostring(AngerFunctions.dec_to_hex_UPPER(player.get_player_host_token(joining_player)))..
									" : is joining")
			
			
			while player.get_host() == nil or type(player.get_host()) ~= "number" 
			 or script.get_host_of_this_script() == nil or type(script.get_host_of_this_script()) ~= "number"
			and utils.time_ms() - start_time < 2000
			do
				--do nothing just wait someone is host
				system.yield(0)
			end
			
			if player.get_host() == joining_player and type(player.get_host()) ~= "number" then
				AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(joining_player).." is the Session Host")
			end
			if script.get_host_of_this_script() == joining_player and type(script.get_host_of_this_script()) ~= "number" then
				AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(joining_player).." is the Script Host")
			end
			
			AngerFunctions.scan_for_spoofing(joining_player, player.get_player_name(joining_player), player.get_player_scid(joining_player), player.get_player_ip(joining_player), player.get_player_host_token(joining_player))


			-----TESTING (to delete at Release)
			AngerFunctions.TESTING(player.get_player_name(joining_player), player.get_player_scid(joining_player), player.get_player_ip(joining_player), player.get_player_host_token(joining_player))
			-----TESTING


			
	end)
	
end


--maybe delete function here
function AngerFunctions.thread_Leave_Event_listening()
	
		--event.remove_event_listener("player_leave", event_listener_id[1])        --if needed
		event_listener_id["player_leave"] = event.add_event_listener("player_leave", function(event)
			local leaving_player = event.player
			local ScrH_migration = false
			local SesH_migration = false
			local start_time = utils.time_ms()
			local timeout_ms = 1000
			
			while (all_player_data[leaving_player] == nil or type (all_player_data[leaving_player]) ~= "table"
			 or all_player_data[leaving_player]["scid"] == nil or type (all_player_data[leaving_player]["scid"]) ~= "table"
			 or all_player_data[leaving_player]["host_token_dec"] == nil or type(all_player_data[leaving_player]["host_token_dec"]) ~= "number"  
			 or all_player_data[leaving_player]["int_ip"] == nil or type(all_player_data[leaving_player]["int_ip"]) ~= "number"  
			 or all_player_data[leaving_player]["name"] == nil or type(all_player_data[leaving_player]["name"]) ~= "string")
			  and utils.time_ms() - start_time < timeout_ms
			do
				system.yield(50)
				--nothing just wait they appear
			end

			--if we had an error of any kind with parameters (timer overflow will occur due to while)
			if (utils.time_ms() - start_time > timeout_ms) then
			else
				AngerFunctions.LogErrors("[ERROR:thread_Leave_Event_listening]: parameter: bad type or nil or timer overflow == >>> scid(leaving_player) = nil"..
				--[[[2021-07-14 01:36:36] [Error] [Failed to resume coroutine] ...oaming\PopstarDevs\2Take1Menu\scripts\Anger Features.lua:3215: attempt to index a nil value (field '?')
				stack traceback:
					...oaming\PopstarDevs\2Take1Menu\scripts\Anger Features.lua:3215: in function <...oaming\PopstarDevs\2Take1Menu\scripts\Anger Features.lua:3194>]]
				--tostring(all_player_data[leaving_player]["scid"])..
				--"; host_token(leaving_player) = "..tostring(all_player_data[leaving_player]["host_token_dec"])..
				--"; ip(leaving_player) = "..tostring(all_player_data[leaving_player]["int_ip"])..
				--"; name(leaving_player) = "..tostring(all_player_data[leaving_player]["name"])..
				"; timer = "..tostring(utils.time_ms() - start_time)..";")
			end

			if all_player_data[leaving_player] ~= nil and type(all_player_data[leaving_player]) == "table" then
				if all_player_data[leaving_player]["scid"] and  all_player_data[leaving_player]["host_token_dec"]
				 and all_player_data[leaving_player]["int_ip"] and all_player_data[leaving_player]["name"]
				then
					-- if it is normal leave (no ScrH_migration or SesH_migration)
					if not all_player_data[leaving_player]["is_script_host"] and not all_player_data[leaving_player]["is_session_host"]
					then
					
						AngerFunctions.LogToFile_AngerAnd2T1(tostring(all_player_data[leaving_player]["name"]).." | "..tostring(all_player_data[leaving_player]["scid"]).." | "..
										tostring(AngerFunctions.intIP_to_strIP(all_player_data[leaving_player]["int_ip"])).." | "..tostring(AngerFunctions.dec_to_hex_UPPER(all_player_data[leaving_player]["host_token_dec"]))
										.." : is leaving")
					
					-- if it is NOT a normal leave (ScrH_migration or SesH_migration)
					elseif all_player_data[leaving_player]["is_script_host"] and all_player_data[leaving_player]["is_session_host"]
					then
						AngerFunctions.LogToFile_AngerAnd2T1(tostring(all_player_data[leaving_player]["name"]).." | "..tostring(all_player_data[leaving_player]["scid"]).." | "..
										tostring(AngerFunctions.intIP_to_strIP(all_player_data[leaving_player]["int_ip"])).." | "..tostring(AngerFunctions.dec_to_hex_UPPER(all_player_data[leaving_player]["host_token_dec"]))
										.." : is leaving. (Was Session Host & Script Host)")
						ScrH_migration = true
						SesH_migration = true
						
					-- if it is NOT a normal leave (ScrH_migration)
					elseif all_player_data[leaving_player]["is_script_host"] and not all_player_data[leaving_player]["is_session_host"]
					then
						AngerFunctions.LogToFile_AngerAnd2T1(tostring(all_player_data[leaving_player]["name"]).." | "..tostring(all_player_data[leaving_player]["scid"]).." | "..
										tostring(AngerFunctions.intIP_to_strIP(all_player_data[leaving_player]["int_ip"])).." | "..tostring(AngerFunctions.dec_to_hex_UPPER(all_player_data[leaving_player]["host_token_dec"]))
										.." : is leaving. (Was Script Host)")
						ScrH_migration = true
						
					-- if it is NOT a normal leave (SesH_migration)
					elseif not all_player_data[leaving_player]["is_script_host"] and all_player_data[leaving_player]["is_session_host"]
					then
						AngerFunctions.LogToFile_AngerAnd2T1(tostring(all_player_data[leaving_player]["name"]).." | "..tostring(all_player_data[leaving_player]["scid"]).." | "..
										tostring(AngerFunctions.intIP_to_strIP(all_player_data[leaving_player]["int_ip"])).." | "..tostring(AngerFunctions.dec_to_hex_UPPER(all_player_data[leaving_player]["host_token_dec"]))
										.." : is leaving. (Was Session Host)")
						SesH_migration = true
					end
					
					
					
					--if we are in lobby and it is not you leaving the lobby
					if player.player_id() ~= nil and type(player.player_id()) == "number" then
						if leaving_player ~= player.player_id() then
							if SesH_migration or ScrH_migration then
								if SesH_migration and ScrH_migration then
									--wait host and script host migration				
									while player.get_host() == leaving_player or player.is_player_host(leaving_player)
									 or script.get_host_of_this_script() == leaving_player
									 or script.get_host_of_this_script() == nil
									 or player.get_host() == nil
									do
										--do nothing just wait (without timeout, above steps should not put us in inifnite loop) 
										system.yield(0)
									end
								elseif SesH_migration and not ScrH_migration then
									--wait host and script host migration				
									while player.get_host() == leaving_player or player.is_player_host(leaving_player)
									 or player.get_host() == nil
									do
										--do nothing just wait (without timeout, above steps should not put us in inifnite loop) 
										system.yield(0)
									end
								elseif ScrH_migration and not SesH_migration then
									--wait host and script host migration	
									while script.get_host_of_this_script() == leaving_player 
									 or script.get_host_of_this_script() == nil
									do
										--do nothing just wait (without timeout, above steps should not put us in inifnite loop)  
										system.yield(0)
									end
								end
								
								for pid = 0,31 do
									--if player at pid exist
									if all_player_data[pid] then
									
										--test if leaving guy was host before and pid is new host
										if (player.is_player_host(pid) and pid == player.get_host()) and all_player_data[leaving_player]["is_session_host"] == true
										then
											all_player_data[leaving_player]["is_session_host"] = false
											all_player_data[pid]["is_session_host"] = true
											
											--warn user
											if User_settings["Session_Host_Migration_Logging"] then
												if player.get_host() ~= player.player_id() then
													AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(player.get_host()).." is the new Session Host")
												else AngerFunctions.LogToFile_AngerAnd2T1("You are the new Session Host")
												end
											end
											if User_settings["Session_Host_Migration_Notification"] then
												if player.get_host() ~= player.player_id() then
													AngerFunctions.Anger_notify(player.get_player_name(player.get_host()).." is the new Session Host", AngerFunctions.RGBA_to_int32_t(0,0,0,255), 7)
												else AngerFunctions.Anger_notify("You are the new Session Host", AngerFunctions.RGBA_to_int32_t(0,255,0,255), 7)
												end
											end
										end
										
										--test if leaving guy was host before and pid is new host
										if script.get_host_of_this_script() == pid and all_player_data[leaving_player]["is_script_host"] == true
										then
											all_player_data[leaving_player]["is_script_host"] = false
											all_player_data[pid]["is_script_host"] = true
											
											--warn user
											if User_settings["Script_Host_Migration_Logging"] then
												if script.get_host_of_this_script() ~= player.player_id() then
													 AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(script.get_host_of_this_script()).." is the new Script Host")
												else AngerFunctions.LogToFile_AngerAnd2T1("You are the new Script Host") 
												end
											end
											if User_settings["Script_Host_Migration_Notification"] then
												if script.get_host_of_this_script() ~= player.player_id() then
													 AngerFunctions.Anger_notify(player.get_player_name(script.get_host_of_this_script()).." is the new Script Host", AngerFunctions.RGBA_to_int32_t(0,0,0,255), 7)
												else AngerFunctions.Anger_notify("You are is the new Script Host", AngerFunctions.RGBA_to_int32_t(0,255,0,255), 7)
												end
											end
										end
										
									end
								end
								
							end
						end
					end
					
					
					all_player_data[leaving_player]["is_leaving_player_process_done"] = true
				end
				
				
			end 
		end)
end

--[[
-------------------------
IMPORTANT : chat commands: include me, friends, crew, other player : 
time  <any time+some keywords>,
weather  <any weather keywords>,
Spawn  <cars,object,ped,clone(loop),god(+normalspawn)>  <player/all/me>, 
vehicle   <fix/god/max(with_F1_tires)/launch/catapult/maxspeed/hornboost/clone/engine/ramp/kick>   <on/off/player/all/other>,
otr  <on/off>  <player/all/me>,
nocops  <on/off/clear>  <player/all/me>,
bounty  <amount>  <player/all/me>,
Kill  <player/all/me>, 
explode  <player/all/me(with answer)/on/off>, 
taze <player/all/me(with answer)/on/off>,
ram  <player/all/me(with answer)/on/off>,
block <passive>  <player/all/me(with answer)/on/off>,

!protex teleport player to 9999 9999 7777 (or around) and place  : https://gta-objects.xyz/objects/sm_prop_smug_hgrground_01
				below the player
help <command/all>
if you type the command sirectly without keywords it explain how it works
Send the command as somone (even if above alrady do)

	TODO : 
money  <player/all/me> (if possible), 
rp  <player/all/me>  (if possible), 
attach some entities / delete entities
/redo that wuold redo last done action by commands
/cage
/vehicle slow
/vehicle fast
/vehicle hornboost
/sms
/send <ped+vehicles whatever> <agressive/bodyguard>
/ceo commands





FAIRE PLUSIEURS CONFIG POUR LES COMMANDS FACILE D4ACC2S A POUVOIR COPI2 POUR UTILISER SEOLONN LES BESOINS
-------------------------
]]



local choices_on_off = {
	on = {
		help = "{{{  on/yes  }}} : used on some commands to activate continuously the feature",
		permissions = {lobby = false, crew = false, team = false, me = false},

		[1] = {"o","n"},
		[2] = {"y","e","s"},
		[3] = {"y"}
	},
	off = {
		help = "{{{  off/no  }}} : used on some commands to deactivate continuously the feature",
		permissions = {lobby = false, crew = false, team = false, me = false},

		[1] = {"n","o"},
		[2] = {"o","f","f"},
		[3] = {"n"}
	}
}
local choices_all = {
	all = {
		help = "{{{  all  }}} : used on some commands to send to every person in the lobby the command called",
		permissions = {lobby = false, crew = false, team = false, me = false},

		[1] = {"a","l","l"},
		[2] = {"a"}
	}
}
local choices_me = {
	me = {
		help = "{{{  me  }}} : used if the user want to activate (or deactivate) the command for himself. "..
				"Ain't really usefull since it will activate (or deactivate) anyway without any parameter",
		permissions = {lobby = false, crew = false, team = false, me = false},

		[1] = {"m","e"},
		[2] = {"m"}
	}
}
local choices_player = { 
	player = {
		help = "{{{  player  }}} : player name targetted by the used command ",
		permissions = {lobby = false, crew = false, team = false, me = false},
	}
}
local choices_model_name = {
	model_name = {
		help = "{{{  model_name/model_reference  }}} : target of the used command ",
		permissions = {lobby = false, crew = false, team = false, me = false},

		[1] = {"m","e"},
		[2] = {"m"}
	}
}
local choices_integer_amount = {
	integer_amount = {
		help = "{{{  integer_amount  }}} : amount for some commands",
		permissions = {lobby = false, crew = false, team = false, me = false},

		[1] = {"m","e"},
		[2] = {"m"}
	}
}
--end general_choices

--maybe make a pre-cutting function so that user don't have to input strange param and will be easier ;)
local commands = 
{
	time = 	
	{ 								 -- <any time+some keywords>
		dev_enable = true,
		state = true,
		help = "help time",

		[1] = {"t","i","m","e"},
		[2] = {"t"},

		choices = {
			midday = {
				state = true,
				help = "help s clone",
				permissions = {lobby = false, crew = false, team = false, me = false},

				[1] = {"c","l","o","n","e"},
				[2] = {"c"}
			},
			midnight = {
				state = true,
				help = "help s god",	
				permissions = {lobby = false, crew = false, team = false, me = false},

				[1] = {"m","i","d","n","i","g","h","t"},
				[2] = {"m"}
			},
			sunrise = {
				state = true,
				help = "help s god",	
				permissions = {lobby = false, crew = false, team = false, me = false},

				[1] = {"s","u","n","r","i","s","e"},
				[2] = {"sr"}
			},
			sunset = {
				state = true,
				help = "help s god",	
				permissions = {lobby = false, crew = false, team = false, me = false},
				
				[1] = {"s","u","n","s","e","t"},
				[2] = {"s"}
			}
		}
		--end time.choices
	},
	--end time
	weather = 
	{													--<any weather keywords>
		dev_enable = true, 	
		state = true,
		help = "help spawn",

		[1] = {"w","e","a","t","h","e","r"},
		[2] = {"w"},

		choices = {
			extrasun = {
				state = true,
				help = "help s clone",
				permissions = {lobby = false, crew = false, team = false, me = false},

				[1] = {"e","x","t","r","a","s","u","n"},
				[2] = {"e","s"}
			},
			sun = {
				state = true,
				help = "help s god",	
				permissions = {lobby = false, crew = false, team = false, me = false},
				
				[1] = {"s","u","n"},
				[2] = {"s"}
			},
			rain = {
				state = true,
				help = "help s god",	
				permissions = {lobby = false, crew = false, team = false, me = false},
				
				[1] = {"r","a","i","n"},
				[2] = {"r"}
			},
			snow = {
				state = true,
				help = "help s god",	
				permissions = {lobby = false, crew = false, team = false, me = false},
				
				[1] = {"s","n","o","w"},
				[2] = {"s","n"}
			}
		}
		--end weather.choices
	},
	--end weather
	spawn = 
	{									--<cars,object,ped,clone(loop),god(+normalspawn)>  <player/all/me>
		dev_enable = true, 
		state = true,
		help = "help spawn",
		choices = { all = choices_all.all },

		[1] = {"s","p","a","w","n"},
		[2] = {"s"},


		subfunctions = {
			clone = {
				dev_enable = true, 
				state = true,
				help = "help s clone",
				choices = {  me = choices_me.me },

				[1] = {"c","l","o","n","e"},
				[2] = {"c"}
			},
			god = {
				dev_enable = true, 
				state = true,
				help = "help s god",
				choices = {},
				
				[1] = {"g","o","d"},
				[2] = {"g"}
			}
		}
		--end spawn.subfunctions
	},
	--end spawn
	vehicle = 
	{--<fix/god/max(with_F1_tires)/jump/launch/catapult/maxspeed/hornboost/clone/engine/ramp/kick>   <on/off/player/all/other>
		dev_enable = true, 
		state = true,
		help = "help vehicle",
		choices = { all = choices_all.all },
		

		[1] = {"v","e","h","i","c","l","e"},
		[2] = {"v"},

		subfunctions = {
			launch = {
				dev_enable = true, 
				state = true,
				help = "help v launch",
				choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },

				[1] = {"l","a","u","n","c","h"},
				[2] = {"l"}
			},
			catapult = {
				dev_enable = true, 
				state = true,
				help = "help v catapult",
				choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },

				[1] = {"c","a","t","a","p","u","l","t"},
				[2] = {"c"}
			},
			god = {
				dev_enable = true, 
				state = true,
				help = "help v god",
				choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },
				
				[1] = {"g","o","d"},
				[2] = {"g"}
			},
			clone = {
				dev_enable = true, 
				state = true,
				help = "help v clone",
				choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },
				
				[1] = {"c","l","o","n","e"},
				[2] = {"c"}
			},
			max = {
				dev_enable = true, 
				state = true,
				help = "help v max",
				choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },
				
				[1] = {"m","a","x"},
				[2] = {"m"}
			},
			jump = {
				dev_enable = true, 
				state = true,
				help = "help v jump",
				choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },
				
				[1] = {"j","u","m","p"},
				[2] = {"j"}
			},
			maxspeed = {
				dev_enable = true, 
				state = true,
				help = "help v maxspeed",
				choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },
				
				[1] = {"m","a","x","s","p","e","e","d"},
				[2] = {"m","s"}
			},
			hornboost = {
				dev_enable = true, 
				state = true,
				help = "help v hornboost",
				choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },
				
				[1] = {"h","o","r","n","b","o","o","s","t"},
				[2] = {"h","b"}
			},
			enginekill = {
				dev_enable = true, 
				state = true,
				help = "help v enginekill",
				choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },
				
				[1] = {"e","n","g","i","n","e","k","i","l","l"},
				[2] = {"h","b"}
			},
			ramp = {
				dev_enable = true, 
				state = true,
				help = "help v ramp",
				choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },
				
				[1] = {"r","a","m","p"},
				[2] = {"r"}
			},
			kick = {
				dev_enable = true, 
				state = true,
				help = "help v kick",
				choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },
				
				[1] = {"k","i","c","k"},
				[2] = {"k"}
			}
		}
		--end vehicle.subfunctions
	},
	--end vehicle
	offradar = 
	{															--<on/off>  <player/all/me>
		dev_enable = true, 
		state = true,
		help = "help offradar",
		choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },

		[1] = {"o","f","f","r","a","d","a","r"},
		[2] = {"o"},
		[3] = {"o","t","r"}
	},
	--end offradar
	cops = 
	{														--<on/off/clear>  <player/all/me>
		dev_enable = true, 
		state = true,
		help = "help no_cops",
		choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },
		
		[1] = {"c","o","p","s"},
		[2] = {"c","o","p"},
		[3] = {"p","o","l","i","c","e"},
		[4] = {"c"}
	},
	--end cops
	bounty = 
	{														--<amount>  <player/all/me>
		dev_enable = true, 
		state = true,
		help = "help bounty",
		choices = { all = choices_all.all, me = choices_me.me },

		[1] = {"b","o","u","n","t","y"},
		[2] = {"b"}
	},
	--end bounty
	kill = 
	{														--<player-player/all/me>
		dev_enable = true, 
		state = true,
		help = "help kill",
		choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },

		[1] = {"b","o","u","n","t","y"},
		[2] = {"b"}
	},
	--end kill
	explode = 
	{												--<player/all/me(with answer)/on/off>
		dev_enable = true, 
		state = true,
		help = "help explode",
		choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },

		[1] = {"e","x","p","l","o","d","e"},
		[2] = {"e"},
		[3] = {"b","o","o","m"}
	},
	--end explode
	taze = 
	{												--<player/all/me(with answer)/on/off>
		dev_enable = true, 
		state = true,
		help = "help taze",
		choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },

		[1] = {"t","a","z","e"},
		[2] = {"s","h","o","c","k"},
		[3] = {"s"}
	},
	--end taze
	ram = 
	{												--<player/all/me(with answer)/on/off>
		dev_enable = true, 
		state = true,
		help = "help ram",
		choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },

		[1] = {"r","a","m"},
		[2] = {"r"}
	},
	--end ram
	block = 
	{												--<player/all/me(with answer)/on/off>
		dev_enable = true, 
		state = true,
		help = "help block",
		
		[1] = {"b","l","o","c","k"},
		[2] = {"b"},
		
		subfunctions = {
			passive = {
				dev_enable = true, 
				state_general = true,
				state_friend = true,
				state_crew = true,
				state_lobby = true,
				help = "help v passive",
				choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },

				[1] = {"p","a","s","s","i","v","e"},
				[2] = {"p"}
			}
		}

		
	},
	--end ram
	protex = 
	{												--<player/all/me>
		dev_enable = true, 
		state = true,
		help = "help protex",
		choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },

		[1] = {"p","r","o","t","e","x"},
		[2] = {"p"}
	},
	--end protex
	bodyguard = 
	{												--<player/all/me>
		dev_enable = true, 
		state = true,
		help = "help bodyguard",
		choices = { on = choices_on_off.on, off = choices_on_off.off, all = choices_all.all, me = choices_me.me },

		[1] = {"b","o","d","y","g","u","a","r","d"},
		[2] = {"b","g"}
	},
	--end protex
	teleport = 
	{												--<player/all/me>
		dev_enable = true, 
		state = true,
		help = "help teleport",
		choices = { all = choices_all.all, me = choices_me.me },

		[1] = {"t","e","l","e","p","o","r","t"},
		[2] = {"t","p"}
	},
	--end teleport
	help = {
		dev_enable = true, 
		state = true,
		help = "help general",
		
		[1] = {"h","e","l","p"},
		[2] = {"h"}
	}
	
}
--if needed
--[[commands.help = {
	time = commands.time.help,
	weather = commands.weather.help,
	spawn = commands.spawn.help,
	vehicle = commands.vehicle.help,
	offradar = commands.offradar.help,
	cop = commands.cop.help,
	bounty = commands.bounty.help,
	kill = commands.kill.help,
	explode = commands.explode.help,
	taze = commands.taze.help,
	protex = commands.protex.help
}]]



function AngerFunctions.display_chat_command_table_here(folder_id)
	AngerFeatures.CommandFolders = {}

	-------TESTING
	AngerFunctions.LogToFile_AngerAnd2T1(tostring("display_chat_command_table:called"))
	-------TESTING

	AngerFeatures.theCommandFolder = menu.add_feature("Commands", "parent", folder_id)

	if commands ~= nil and type(commands) == "table" then
		for each_command, each_command_table in pairs (commands) do
			
			if each_command_table ~= nil and type(each_command_table) == "table" then
				if each_command_table.dev_enable and each_command ~= nil  then

					AngerFeatures.CommandFolders[each_command] = {}
					-------TESTING
					AngerFunctions.LogToFile_AngerAnd2T1(tostring("command : "..tostring(each_command)))
					-------TESTING

					AngerFeatures.CommandFolders[each_command].main_command_folder = menu.add_feature(each_command, "parent", folder_id)
					
					-- STATE
					AngerFeatures.with_toggle["Anger_Commands_"..tostring(each_command).."_state"] = menu.add_feature("Activate \""..tostring(each_command).."\" Chat Command", "toggle", AngerFeatures.CommandFolders[each_command].main_command_folder.id, function(feature)
						if feature.on then
							commands[each_command].state = true
						else
							commands[each_command].state = false
						end
					end)

					-- HELP
					AngerFeatures.with_toggle["Anger_Commands_"..tostring(each_command).."_help"] = menu.add_feature("Modify \"help\" for this Command", "action", AngerFeatures.CommandFolders[each_command].main_command_folder.id, function(feature)
						if feature.on then
							commands[each_command].help = AngerFunctions.get_user_input("Modify \"help\" for this Command", "test", 10, int_INPUT_TYPES.ALPHA_NUM)
						else
							commands[each_command].help = AngerFunctions.get_user_input("Modify \"help\" for this Command", "test", 10, int_INPUT_TYPES.ALPHA_NUM)
						end
					end)
					

					-- DETECTION STRINGS
					AngerFeatures.CommandFolders[each_command].command_strings_folder = menu.add_feature("Add / Delete detection strings", "parent", AngerFeatures.CommandFolders[each_command].main_command_folder.id)
					
							--Add new detection string for the command
							menu.add_feature("Add a detection word for this Command", "action", AngerFeatures.CommandFolders[each_command].command_strings_folder.id, function(feature)
								if feature.on then
									commands[each_command][#each_command_table + 1] = AngerFunctions.get_user_input("Add a detection word", "test", 10, int_INPUT_TYPES.ALPHA_NUM)
								end
							end)
							
							for i = 1, #each_command_table do
								if i ~= nil then
									local concatenated_command_string = AngerFunctions.concatenate_or_split_str_to_char_table("", each_command_table[i], "c")
									--init new User_Settings for command_state
									AngerFeatures.with_toggle["Anger_Commands_"..tostring(each_command).."_"..tostring(i)] = 
										menu.add_feature("     "..tostring(concatenated_command_string), "action", 
										AngerFeatures.CommandFolders[each_command].command_strings_folder.id, 
									function(feature)

										if feature.on then
											local index = i
											--delete the alternative detection string 
											table.remove(commands[each_command], i)
											feature.hidden = true
										end

									end)
								end
							end


					-- PERMISSIONS
					AngerFeatures.CommandFolders[each_command].command_permissions_folder = menu.add_feature("Change Permissions", "parent", AngerFeatures.CommandFolders[each_command].main_command_folder.id)
						AngerFeatures.CommandFolders[each_command].command_permissions_subfolder = {}
							
							for key2, value in pairs(each_command_table.choices) do
								local display_string = ""
								--choices_player choices_model_name choices_integer_amount on off all me
								if key2 == "on" then display_string = "Can user activate continuously the command ?"
								elseif key2 == "off" then display_string = "Can user activate continuously the command ?"
								elseif key2 == "all" then display_string = "Can user activate continuously the command ?"
								elseif key2 == "me" then display_string = "Can user activate continuously the command ?"
								elseif key2 == "choices_player" then display_string = "Can user send the command on a player?"
								elseif key2 == "choices_model_name" then display_string = "Can user user call a model name for the command ?"
								elseif key2 == "choices_integer_amount" then display_string = "Can user user set an amount for the command ?"
								end
								

								AngerFeatures.CommandFolders[each_command].command_permissions_subfolder[key2] = 
									menu.add_feature(tostring(display_string), "parent", 
									AngerFeatures.CommandFolders[each_command].command_permissions_folder.id)

									for each_perm, value_perm in pairs(each_command_table.choices[key2]) do

										local sub_display_string = ""
										--{lobby = false, crew = false, team = false, me = false},
										if each_perm == "lobby" then sub_display_string = "Can user activate continuously the command ?"
										elseif each_perm == "crew" then sub_display_string = "Can user activate continuously the command ?"
										elseif each_perm == "team" then sub_display_string = "Can user activate continuously the command ?"
										elseif each_perm == "me" then sub_display_string = "Can user activate continuously the command ?"
										end


										AngerFeatures.with_toggle["Anger_Commands_"..tostring(each_command).."_"..tostring(key2)] = 
											menu.add_feature("     "..tostring(sub_display_string), "toggle", 
											AngerFeatures.CommandFolders[each_command].command_permissions_subfolder[key2].id, 
										function(feature)

											if feature.on then
												commands[each_command].choices[key2] = true
											else 
												commands[each_command].choices[key2] = false
											end

										end)
									end
							end
					



					-- SUBFUNCTIONS
					if each_command_table.subfunctions ~= nil and type(each_command_table.subfunctions) == "table" then
						AngerFeatures.CommandFolders[each_command].sub_command_folder = menu.add_feature("Sub Commands", "parent", AngerFeatures.CommandFolders[each_command].main_command_folder.id)
					
							for i = 1, #each_command_table.subfunctions do
								if each_command_table.subfunctions[i] ~= nil then
									---CALL SYSTEM FOR SUB_FUNCTIONS
								end
							end
					end

				end
			end

		end
	end

end


function AngerFunctions.scan_command_nil_param(chating_player, chat_message, team_only_message, command_strings)
	-------TESTING
	AngerFunctions.LogToFile_AngerAnd2T1(tostring("scan_command_nil_param:caklled"))
	-------TESTING
	
	if command_strings ~= nil and type(command_strings) == "table" 
	 and command_strings.help ~= nil and type(command_strings.help) == "string"
	then
		network.send_chat_message(command_strings.help, team_only_message)
	else
		-------TESTING
		AngerFunctions.LogToFile_AngerAnd2T1(tostring("command_nil:caklled"))
		-------TESTING
	end
end

-----SUB COMMAND SCAN without parameter
function AngerFunctions.scan_sub_command_nil_param(chating_player, chat_message, team_only_message, sub_command_strings)
	-------TESTING
	AngerFunctions.LogToFile_AngerAnd2T1(tostring("scan_sub_command_nil_param:caklled"))
	-------TESTING
	
	if sub_command_strings ~= nil and type(sub_command_strings) == "table" 
	 and sub_command_strings.help ~= nil and type(sub_command_strings.help) == "string"
	then
		network.send_chat_message(sub_command_strings.help, team_only_message)
	else
		-------TESTING
		AngerFunctions.LogToFile_AngerAnd2T1(tostring("sub_command_nil:caklled"))
		-------TESTING
	end
end

-----SUB COMMAND SCAN (verhicle jump <me/player..>, vehicle launch ....)
function AngerFunctions.scan_sub_command_not_nil_param(chating_player, chat_message, team_only_message, sub_command_strings, sub_parameter_string)
	-------TESTING
	AngerFunctions.LogToFile_AngerAnd2T1(tostring("scan_sub_command_not_nil_param:caklled"))
	-------TESTING
	
	--CUT parameter into param 1 , 2 , 3, 4, 5, etc... then 
		--TODO ACTIONS FOR THE COMMANDS
end


-----COMMAND SCAN (spawn <object/me/player..>, ... )
-----AND SEND TO SUB_COMMANDS_SCAN SYSTEM
function AngerFunctions.scan_command_not_nil_param(chating_player, chat_message, team_only_message, command_strings, parameter_string)
	-------TESTING
	AngerFunctions.LogToFile_AngerAnd2T1(tostring("scan_command_not_nil_param:caklled"))
	-------TESTING

	local sub_pattern_command_string_match = false
	if command_strings.subfunctions ~= nil and  type(command_strings.subfunctions) == "table" 
	then
		for sub_command_name, sub_command_strings in pairs(command_strings.subfunctions) do
			if sub_pattern_command_string_match then
				break
			elseif sub_command_strings ~= nil and  type (sub_command_strings) == "table" 
			then
				-------TESTING
				AngerFunctions.LogToFile_AngerAnd2T1("SUBlength:"..tostring(#sub_command_strings))
				-------TESTING
				for i = 1, #sub_command_strings do
					-------TESTING
					AngerFunctions.LogToFile_AngerAnd2T1(tostring(tostring(i)..":i;SUBlength:"..tostring(#sub_command_strings)))
					-------TESTING
					local pattern
					--add beginning of pattern symbol
					pattern = "^(["
					-------TESTING
					AngerFunctions.LogToFile_AngerAnd2T1(tostring(tostring(i)..":i;SUBlength:"..tostring(#sub_command_strings[i])))
					-------TESTING
					for	j = 1, #sub_command_strings[i] do
						--for each command sub stirngs we add to the pattern upper and lower case
						pattern = pattern..string.lower(tostring(sub_command_strings[i][j]))..string.upper(tostring(sub_command_strings[i][j]))
						-------TESTING
						AngerFunctions.LogToFile_AngerAnd2T1(tostring("SUBij:"..tostring(i)..tostring(j)))
						-------TESTING
						--if else: we are at the last char of the pattern
						if j == #sub_command_strings[i] then
							pattern = pattern.."]+)%s*"
						else
							pattern = pattern.."]+["
						end
					end
				
				
					-------TESTING
					AngerFunctions.LogToFile_AngerAnd2T1(tostring("SUBpattern:"..tostring(pattern)))
					-------TESTING

					local punct_char_min, punct_char_max = parameter_string:find(pattern)
					local sub_parameter_string = ""
					local sub_command_string = ""
					if punct_char_min ~= nil then

						sub_pattern_command_string_match = true
						
						if punct_char_max ~= nil then
						sub_parameter_string = parameter_string:sub(punct_char_max+1, string.len(parameter_string))
						sub_command_string = parameter_string:sub(0, punct_char_max)
						-------TESTING
						AngerFunctions.LogToFile_AngerAnd2T1(tostring("SUBpunct_char_max different from nil:"..tostring(punct_char_max).."(punct_char_min:"..tostring(punct_char_min)..")"))
						-------TESTING
						else
							sub_parameter_string = parameter_string:sub(punct_char_min+1, string.len(parameter_string))
							sub_command_string = parameter_string:sub(0, punct_char_min+1)
							-------TESTING
							AngerFunctions.LogToFile_AngerAnd2T1(tostring("SUBpunct_char_min different from nil:"..tostring(punct_char_min).."(punct_char_max:"..tostring(punct_char_max)..")"))
							-------TESTING
						end
					end

					if sub_pattern_command_string_match then
						-------TESTING
						AngerFunctions.LogToFile_AngerAnd2T1(tostring(sub_command_string))
						-------TESTING

						--test if the command string (and not aprameter) have a space at the end (means there is a parameter)
						local sub_test_help_function = sub_command_string:find("%s$")

						-------TESTING
						AngerFunctions.LogToFile_AngerAnd2T1(tostring(sub_test_help_function))
						-------TESTING

						if sub_parameter_string ~= nil and sub_parameter_string ~= "" and sub_test_help_function ~= nil
						and type(sub_parameter_string) == "string" and type(sub_test_help_function) == "number" 
						then
							-------TESTING
							AngerFunctions.LogToFile_AngerAnd2T1(tostring("SUBparameter different from nil:"..tostring(sub_parameter_string)))
							-------TESTING
							
							AngerFunctions.scan_sub_command_not_nil_param(chating_player, chat_message, team_only_message, sub_command_strings, sub_parameter_string)

							break;
						else
							-------TESTING
							AngerFunctions.LogToFile_AngerAnd2T1(tostring("SUBparameter nil:"..tostring(sub_parameter_string)))
							-------TESTING
							
							AngerFunctions.scan_sub_command_nil_param(chating_player, chat_message, team_only_message, sub_command_strings)

						end
					end
				end
			else
				-------TESTING
				AngerFunctions.LogToFile_AngerAnd2T1(tostring("command_strings.subfunctions not table or nil"))
				-------TESTING
			end
		end
	end

	if not sub_pattern_command_string_match then
		-------TESTING
		AngerFunctions.LogToFile_AngerAnd2T1(tostring("SUBsub_pattern_command_string_match fasle"))
		-------TESTING
		
		--CUT parameter into param 1 , 2 , 3, 4, 5, etc... then 
		--TODO ACTIONS FOR THE COMMANDS
	end
end


------GENERAL CHAT SCANNING
function AngerFunctions.scan_chat_entry(chating_player, chat_message, team_only_message)
	-------------TESTING
	chat_message = "!!!!!!  h"
	-------TESTING
	local punct_char_min, punct_char_max = chat_message:find("^%p+%s*")
	if punct_char_min ~= nil and  type(punct_char_min) == "number"
	then
		-------TESTING
		AngerFunctions.LogToFile_AngerAnd2T1(tostring("punct detected:"..tostring(punct_char_min)..":"..tostring(punct_char_max)))
		-------TESTING
		local string_without_punct = chat_message:sub(punct_char_max+1)

		if string_without_punct ~= nil and string_without_punct ~= "" and type(string_without_punct) == "string" then
			-------TESTING
			AngerFunctions.LogToFile_AngerAnd2T1(tostring("string_without_punct:"..tostring(string_without_punct)))
			-------TESTING

			local pattern_command_string_match = false
			for command_name, command_strings in pairs(commands) do
				if pattern_command_string_match then
					break
				elseif command_strings ~=nil and type(command_strings) == "table" then
					
						--[[EXEMPLE : 
						pattern = "^(["..string.lower(tostring(command_strings[1][1]))..string.upper(tostring(command_strings[1][1])).."]+["..
								string.lower(tostring(command_strings[1][2]))..string.upper(tostring(command_strings[1][2])).."]+["..
								string.lower(tostring(command_strings[1][3]))..string.upper(tostring(command_strings[1][3])).."]+["..
								string.lower(tostring(command_strings[1][4]))..string.upper(tostring(command_strings[1][4])).."]+["..
								string.lower(tostring(command_strings[1][5]))..string.upper(tostring(command_strings[1][5])).."]+)%s*"]]
					
					for i = 1, #command_strings do
						AngerFunctions.LogToFile_AngerAnd2T1(tostring(tostring(i)..":i;length:"..tostring(#command_strings)))
						local pattern
						--add beginning of pattern symbol
						pattern = "^(["
						-------TESTING
						AngerFunctions.LogToFile_AngerAnd2T1(tostring(tostring(i)..":i;length:"..tostring(#command_strings[i])))
						-------TESTING
						for	j = 1, #command_strings[i] do
							--for each command sub stirngs we add to the pattern upper and lower case
							pattern = pattern..string.lower(tostring(command_strings[i][j]))..string.upper(tostring(command_strings[i][j]))
							-------TESTING
							AngerFunctions.LogToFile_AngerAnd2T1(tostring("ij:"..tostring(i)..tostring(j)))
							-------TESTING
							--if else: we are at the last char of the pattern
							if j == #command_strings[i] then
								pattern = pattern.."]+)%s*"
							else
								pattern = pattern.."]+["
							end
						end
					
					
						-------TESTING
						AngerFunctions.LogToFile_AngerAnd2T1(tostring("pattern:"..tostring(pattern)))
						-------TESTING

						punct_char_min, punct_char_max = string_without_punct:find(pattern)
						local parameter_string = ""
						local command_string = ""
						if punct_char_min ~= nil then

							pattern_command_string_match = true
							
							if punct_char_max ~= nil then
							parameter_string = string_without_punct:sub(punct_char_max+1, string.len(string_without_punct))
							command_string = string_without_punct:sub(0, punct_char_max)
							-------TESTING
							AngerFunctions.LogToFile_AngerAnd2T1(tostring("punct_char_max different from nil:"..tostring(punct_char_max).."(punct_char_min:"..tostring(punct_char_min)..")"))
							-------TESTING
							else
								parameter_string = string_without_punct:sub(punct_char_min+1, string.len(string_without_punct))
								command_string = string_without_punct:sub(0, punct_char_min+1)
								-------TESTING
								AngerFunctions.LogToFile_AngerAnd2T1(tostring("punct_char_min different from nil:"..tostring(punct_char_min).."(punct_char_max:"..tostring(punct_char_max)..")"))
								-------TESTING
							end
						end

						if pattern_command_string_match then
							-------TESTING
							AngerFunctions.LogToFile_AngerAnd2T1(tostring(command_string))
							-------TESTING

							--test if the command string (and not aprameter) have a space at the end (means there is a parameter)
							local test_help_function = command_string:find("%s$")

							-------TESTING
							AngerFunctions.LogToFile_AngerAnd2T1(tostring(test_help_function))
							-------TESTING

							if parameter_string ~= nil and parameter_string ~= "" and test_help_function ~= nil
							and type(parameter_string) == "string" and type(test_help_function) == "number" 
							then
								-------TESTING
								AngerFunctions.LogToFile_AngerAnd2T1(tostring("parameter different from nil:"..tostring(parameter_string)))
								-------TESTING
								
								AngerFunctions.scan_command_not_nil_param(chating_player, chat_message, team_only_message, command_strings, parameter_string)

								break;
							else
								-------TESTING
								AngerFunctions.LogToFile_AngerAnd2T1(tostring("parameter nil:"..tostring(parameter_string)))
								-------TESTING
								
								AngerFunctions.scan_command_nil_param(chating_player, chat_message, team_only_message, command_strings)

							end
						end
					end
				end
			end

	

	
		end
	end
end


--maybe delete fuction here
function AngerFunctions.thread_Chat_listening()
	event_listener_id["chat"] = event.add_event_listener("chat", function(event)
		
		if type(event) == "userdata" then
			local chating_player = event.player
			local chat_message = event.body
				
			if User_settings["Chat_Logging"] and chat_message ~= nil then	
				if player.get_player_name(chating_player) == nil then
					AngerFunctions.LogToFile_AngerAnd2T1("[ANGER_BUGGED_NAME:PID="..tostring(chating_player).."] [CHAT] "..tostring(chat_message))

					AngerFunctions.LogErrors("[ERROR:thread_Chat_listening]: parameter: bad type or nil == >>> chating_player = "..
					tostring(chating_player).."; chat_message = "..
					tostring(chat_message)..";")
				else
					AngerFunctions.LogToFile_AngerAnd2T1(tostring(player.get_player_name(chating_player)).." [CHAT] "..tostring(chat_message))
					
					if User_settings["ChatCommand_State"] == true then
						--scan_chat_entry(chating_player, chat_message, true--[[team_only_message]])
					end
				end
			end
		end
	end)
end

--NUTS IN HERE WHEN CHANGING LOBBY

function AngerFunctions.thread_scan_Script_Host_Migration()
	while true do
		if (AngerFunctions.am_i_fully_loaded_in_session(true)) then  --true = avoid waiting

			local old_SH_name;
			local old_SH_pid;
			if all_player_data[script.get_host_of_this_script()] ~= nil 
			 and type (all_player_data[script.get_host_of_this_script()]) == "table" 
			then
				if all_player_data[script.get_host_of_this_script()]["is_script_host"] ~= true then
					for pid = 0,31 do
						if all_player_data[pid] ~= nil and type(all_player_data[pid]) == "table"
						then
							if all_player_data[pid]["is_script_host"] == true then
								old_SH_name = all_player_data[pid]["name"]
								old_SH_pid = pid
							end
						end
						system.yield(10)
					end

					if old_SH_pid ~= nil and type(old_SH_pid) == "number"
						and old_SH_name ~= nil and type(old_SH_name) == "string"
						and script.get_host_of_this_script() ~= nil and type(script.get_host_of_this_script()) == "number"
						and all_player_data[script.get_host_of_this_script()] ~= nil
						and all_player_data[script.get_host_of_this_script()]["is_script_host"] ~= nil
						and all_player_data[old_SH_pid] ~= nil
						and all_player_data[old_SH_pid]["is_script_host"] ~= nil
						and type(all_player_data[old_SH_pid]) == "table"
						and type(all_player_data[script.get_host_of_this_script()]) == "table"
						and player.get_player_name(script.get_host_of_this_script()) ~= nil
						and old_SH_name ~= tostring(player.get_player_name(script.get_host_of_this_script()))
					then
						all_player_data[script.get_host_of_this_script()]["is_script_host"] = true
						all_player_data[old_SH_pid]["is_script_host"] = true

						if User_settings["Script_Host_Migration_Logging"] then
							if script.get_host_of_this_script() == player.player_id() then
								AngerFunctions.LogToFile_AngerAnd2T1("You are the new Script Host") 
							else AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(script.get_host_of_this_script()).." is the new Script Host")
							end
						end
						if User_settings["Script_Host_Migration_Notification"] then
							if script.get_host_of_this_script() == player.player_id() then
								AngerFunctions.Anger_notify("You are is the new Script Host", AngerFunctions.RGBA_to_int32_t(0,255,0,255), 7)
							else AngerFunctions.Anger_notify(player.get_player_name(script.get_host_of_this_script()).." is the new Script Host", AngerFunctions.RGBA_to_int32_t(0,0,0,255), 7)
							end
						end	
					end
				end
			end
		end

		system.yield(300)  --no need to check that more oftenly it's already not a lot for human
	end
end

----------------------------- CONTINUE HERE

--[[/***************************** MODDER DETECTION THREAD(S) / FUNCTIONS **********************************************/]]



--X check with timeout to avoid false detection
local minimum_possible_detections_before_successful_detection_for_modder_flag = 
{
	["Ang-Godmode"] = 5, --to avoid more than 95+% false detection 
	["Ang-VehicleGodmode"] = 5,  --to avoid more than 95+% false detection 
	["Ang-Godmode-Aiming"] = 1,  --cant have false detection
	["Ang-HealthMod"] = 1        --cant have false detection
}
--to be sure user was possibly detected for somthing in previous seconds
local maximum_time_in_between_possible_detections =   --ms    SHOULD BE USER DEFINED
{
	["Ang-Godmode"] = 3500,     	---3'500ms = 3.5sec
	["Ang-VehicleGodmode"] = 4500,  ---4'500ms = 4.5sec
	["Ang-Godmode-Aiming"] = 0,     ---4'500ms = 4.5sec
	["Ang-HealthMod"] = 0
}
--dont warn user of successful detection under this timing
local minimum_time_in_between_successful_detections =   --ms   SHOULD BE USER DEFINED
{
	["Ang-Godmode"] = 120000,   	---300'000ms = 5min
	["Ang-VehicleGodmode"] = 120000,
	["Ang-Godmode-Aiming"] = 0,
	["Ang-HealthMod"] = 120000
}
local all_detected_data = {}  -- 3D array : all_detected_data[X]  ==> for each X we have a specific player datas
									--		all_detected_data[X][Y] ==> for Y = 0 		: we have player_scid
									--								==> for Y = 1 		: we have "Ang-Godmode" detection
									--								==> for Y = 2 		: we have "Ang-VehicleGodmode" detection
									--								==> for Y = 3 		: we have "Ang-Godmode-Aiming" detection
									--							======> for Y = 4 to n  : we have others detections
									--									==> for Z = 1 : last_detection_time (time_ms()) of specific player
									--									==> for Z = 2 : number_of_detection of specific player in last_detection_time
									--									==> for Z = 3 : last_successful_detection_time (time_ms()) of specific player
									--									==> for Z = 4 : number_of_successful_detection of specific player in last_detection_time
									
		
function AngerFunctions.init_new_detected_data_for_player(count, player_scid)
	if count ~= nil and type(count) == "number" 
	and player_scid ~= nil and type(player_scid) == "number" then
		all_detected_data[count] = 
		{ 
			["scid"] = player_scid,
			["Ang-Godmode"] =
			{
				["last_detection_time"] = 0,
				["number_of_detection"] = 0,
				["last_successful_detection_time"] = 0,
				["number_of_successful_detection"] = 0
			},
			["Ang-VehicleGodmode"] =
			{
				["last_detection_time"] = 0,
				["number_of_detection"] = 0,
				["last_successful_detection_time"] = 0,
				["number_of_successful_detection"] = 0
			},
			["Ang-Godmode-Aiming"] =
			{
				["last_detection_time"] = 0,
				["number_of_detection"] = 0,
				["last_successful_detection_time"] = 0,
				["number_of_successful_detection"] = 0
			}
		}
	end
end


--[[Scan detection of all types to transform a possible detection into a succefful one 
		and avoid false detection
	TODO : part not handled yet :- deletion of a modder
						- if user want every detection or only a single	time	
						- if the Angers_modder_flag are stil on user but he is not in all_detected_data (---> Refresh LUA state from user)]]
function AngerFunctions.scan_detected_scid(player_scid, string_modder_flag)
		local err = false  --regional error variable
		local was_detected_alrdy_or_deleted_or_need_more_details = false   --if any bug we still say to user the detection
		local was_possibly_detected = false
		local player_exist_in_all_detected_data = false --supposed at beginning
		local i = 0
		local j = 0
		local current_time
		if utils.time_ms() ~= nil and type(utils.time_ms())=="number" then
			current_time = utils.time_ms()
		else err = true end
		local current_size_of_all_detected_data
		if all_detected_data ~= nil and type(all_detected_data)=="table" then
			current_size_of_all_detected_data = AngerFunctions.table_or_array_Length(all_detected_data)
		else err = true end
		
																-- =current index+1 of the table (new data to save)
																-- =current_size (at begining of function) of_all_detected_data
																
		-----TESTING
		--LogToFile_AngerAnd2T1("i'm in")
		-----TESTING
		if err ~= true and current_time ~= nil and current_size_of_all_detected_data ~= nil
		then
		--if we have no data in all_detected_data and a specific player was possibly detected for modder_flag 
			if (current_size_of_all_detected_data < 1) then
				-----TESTING
				--LogToFile_AngerAnd2T1("there was no user detected")
				-----TESTING
				AngerFunctions.init_new_detected_data_for_player(0, player_scid)
				was_detected_alrdy_or_deleted_or_need_more_details = true
				
				if all_detected_data ~= nil 
				 and type(all_detected_data) == "table"
				 and all_detected_data[0] ~= nil 
				 and type(all_detected_data[0]) == "table"
				 and all_detected_data[0][string_modder_flag] ~= nil 
				 and type(all_detected_data[0][string_modder_flag]) == "table"
				 and all_detected_data[0][string_modder_flag]["last_detection_time"] ~= nil 
				 and type(all_detected_data[0][string_modder_flag]["last_detection_time"]) == "number"
				 and all_detected_data[0][string_modder_flag]["number_of_detection"] ~= nil
				 and type(all_detected_data[0][string_modder_flag]["number_of_detection"]) == "number"
				then
					all_detected_data[0][string_modder_flag]["last_detection_time"] = current_time
					all_detected_data[0][string_modder_flag]["number_of_detection"] = --[[=0+1 normally]] all_detected_data[0][string_modder_flag]["number_of_detection"] + 1  
				else
					AngerFunctions.LogErrors("[ERROR:scan_detected_scid]: all_detected_data: case nobody in array: bad type or nil == >>> "..
					--tostring(all_detected_data[0][string_modder_flag]["number_of_detection"])..
					--"; timdetec = "..tostring(all_detected_data[0][string_modder_flag]["last_detection_time"])..
					"; str = "..tostring(all_detected_data[0][string_modder_flag])..
					"; 0 = "..tostring(all_detected_data[0])..
					"; base = "..tostring(all_detected_data)..
					";")
				end


			--we have one or multiple player detected, not necessarly succefully, test if the new detection alrdy have past detection
			elseif  (current_size_of_all_detected_data > 0) then
				for i = 0, current_size_of_all_detected_data - 1 do
					if player_scid == all_detected_data[i]["scid"] 
					and all_detected_data ~= nil 
					and type(all_detected_data) == "table"
					and all_detected_data[i] ~= nil 
					and type(all_detected_data[i]) == "table"
					and all_detected_data[i][string_modder_flag] ~= nil 
					and type(all_detected_data[i][string_modder_flag]) == "table"
					and all_detected_data[i][string_modder_flag]["last_detection_time"] ~= nil 
					and type(all_detected_data[i][string_modder_flag]["last_detection_time"]) == "number"
					and all_detected_data[i][string_modder_flag]["number_of_detection"] ~= nil
					and type(all_detected_data[i][string_modder_flag]["number_of_detection"]) == "number"
					and all_detected_data[i][string_modder_flag]["number_of_successful_detection"] ~= nil 
					and type(all_detected_data[i][string_modder_flag]["number_of_successful_detection"]) == "number"
					and all_detected_data[i][string_modder_flag]["last_successful_detection_time"] ~= nil
					and type(all_detected_data[i][string_modder_flag]["last_successful_detection_time"]) == "number"
				   then  -- the specific player detected ALREADY have some detected_datas initilized
						
						player_exist_in_all_detected_data = true
						-----TESTING
						--LogToFile_AngerAnd2T1("the user exist in listing")
						-----TESTING
						
						-- previous comment : (==> if player was not succefully detected in previous authorized timing by user or was never succefully detected)
						--if the guy with some detection didnt started confirmation of detection, OR if he didnt succeed previous process of confirmation  
						--OR if his last succeful detection is above the minimum timing recquired by user :
								--if (current_time - time_at_detection) > minimum_time_in_between_successful_detections[string_modder_flag]
						if all_detected_data[i][string_modder_flag]["last_successful_detection_time"] == 0
						 or (current_time - all_detected_data[i][string_modder_flag]["last_detection_time"]) <= maximum_time_in_between_possible_detections[string_modder_flag]
						 or (current_time - all_detected_data[i][string_modder_flag]["last_successful_detection_time"]) > minimum_time_in_between_successful_detections[string_modder_flag]
						then
							-----TESTING
							--LogToFile_AngerAnd2T1("the user has possible detection before")
							-----TESTING
							
							--player was ALREADY detected for this specific modder_flag 
								--but last_detection_time IS NOT IN interval maximum_time_in_between_possible_detections  (-->this is A FALSE detection)
								
								---->then we save a new possible detection
							if (all_detected_data[i][string_modder_flag]["last_detection_time"] > 0 
							 and (current_time - all_detected_data[i][string_modder_flag]["last_detection_time"]) > maximum_time_in_between_possible_detections[string_modder_flag])
							then
								-----TESTING
								--LogToFile_AngerAnd2T1("(-->this is A FALSE detection)")
								-----TESTING
								was_detected_alrdy_or_deleted_or_need_more_details = true
								all_detected_data[i][string_modder_flag]["last_detection_time"] = 0  --reset timer
								all_detected_data[i][string_modder_flag]["number_of_detection"] = 0  --reset counter
							
							
							
							--player was ALREADY detected for this specific modder_flag 
								--and last_detection_time IS IN interval maximum_time_in_between_possible_detections   (-->this is POSSIBLY true detection)
								--BUT we didn't reached minimum_possible_detections_before_successful_detection_for_modder_flag 
								--or player was NEVER detected for this specific modder_flag 
								---->then we save a previous possible detection + 1
							elseif (all_detected_data[i][string_modder_flag]["last_detection_time"] > 0 
							 and (current_time - all_detected_data[i][string_modder_flag]["last_detection_time"]) <= maximum_time_in_between_possible_detections[string_modder_flag]
							 and all_detected_data[i][string_modder_flag]["number_of_detection"] < minimum_possible_detections_before_successful_detection_for_modder_flag[string_modder_flag])
							 or all_detected_data[i][string_modder_flag]["last_detection_time"] == 0
							then
								-----TESTING
								--LogToFile_AngerAnd2T1("(-->this is POSSIBLY true detection)")
								-----TESTING
								was_detected_alrdy_or_deleted_or_need_more_details = true
								all_detected_data[i][string_modder_flag]["last_detection_time"] = current_time
								all_detected_data[i][string_modder_flag]["number_of_detection"] = all_detected_data[i][string_modder_flag]["number_of_detection"] + 1
							
							--player was ALREADY detected for this specific modder_flag 
								--and last_detection_time IS IN interval maximum_time_in_between_possible_detections
								-- and we reached minimum_possible_detections_before_successful_detection_for_modder_flag   (-->this is A TRUE detection)
								---->then we save a successful detection + 1 and send notif & log 
							elseif (all_detected_data[i][string_modder_flag]["last_detection_time"] > 0 
							 and (current_time - all_detected_data[i][string_modder_flag]["last_detection_time"]) <= maximum_time_in_between_possible_detections[string_modder_flag]
							 and all_detected_data[i][string_modder_flag]["number_of_detection"] >= minimum_possible_detections_before_successful_detection_for_modder_flag[string_modder_flag])
							then
								-----TESTING
								--LogToFile_AngerAnd2T1("(-->this is A TRUE detection)")
								-----TESTING
								was_detected_alrdy_or_deleted_or_need_more_details = false
								all_detected_data[i][string_modder_flag]["last_successful_detection_time"] = current_time
								all_detected_data[i][string_modder_flag]["number_of_successful_detection"] = all_detected_data[i][string_modder_flag]["number_of_successful_detection"] + 1
								all_detected_data[i][string_modder_flag]["last_detection_time"] = 0  --reset timer
								all_detected_data[i][string_modder_flag]["number_of_detection"] = 0  --reset counter
								
							end
							
						--------------PROBLEM IN HERE IT DONT GO IN (WORKS NOW o,0 TO INVESTGIGATE)
						--previous comment : (==> if player was succefully detected in previous timing)
						--elseif the guy was succefully detected once for this modder_flag
							--and all_detected_data[i][string_modder_flag]["last_successful_detection_time"] IS IN interval minimum_time_in_between_successful_detections[string_modder_flag]
						elseif (all_detected_data[i][string_modder_flag]["number_of_successful_detection"] > 0
						 and (current_time - all_detected_data[i][string_modder_flag]["last_successful_detection_time"]) <= minimum_time_in_between_successful_detections[string_modder_flag])
						then
							-----TESTING
							--LogToFile_AngerAnd2T1("Detected another time after succesful but too soon")
							-----TESTING
							was_detected_alrdy_or_deleted_or_need_more_details = true
						end
						
					end
				end  --end for
				
				-- we save him for new detection if he has no data saved already and that all_detected_data is populated by one more or more (any) detection
				if not player_exist_in_all_detected_data and current_size_of_all_detected_data > 0 then  
					-----TESTING
					--LogToFile_AngerAnd2T1("all_detected_data have data but this guy dont exist in")
					-----TESTING
					AngerFunctions.init_new_detected_data_for_player(current_size_of_all_detected_data, player_scid)
					was_detected_alrdy_or_deleted_or_need_more_details = true
					
					if all_detected_data ~= nil 
					and type(all_detected_data) == "table"
					and all_detected_data[current_size_of_all_detected_data] ~= nil 
					and type(all_detected_data[current_size_of_all_detected_data]) == "table"
					and all_detected_data[current_size_of_all_detected_data][string_modder_flag] ~= nil 
					and type(all_detected_data[current_size_of_all_detected_data][string_modder_flag]) == "table"
					and all_detected_data[current_size_of_all_detected_data][string_modder_flag]["last_detection_time"] ~= nil 
					and type(all_detected_data[current_size_of_all_detected_data][string_modder_flag]["last_detection_time"]) == "number"
					and all_detected_data[current_size_of_all_detected_data][string_modder_flag]["number_of_detection"] ~= nil
					and type(all_detected_data[current_size_of_all_detected_data][string_modder_flag]["number_of_detection"]) == "number"
					then
						all_detected_data[current_size_of_all_detected_data][string_modder_flag]["last_detection_time"] = current_time
						all_detected_data[current_size_of_all_detected_data][string_modder_flag]["number_of_detection"] =  --[[=actual_size+1 normally]] all_detected_data[current_size_of_all_detected_data][string_modder_flag]["number_of_detection"] + 1 
					else
						AngerFunctions.LogErrors("[ERROR:scan_detected_scid]: all_detected_data: case player not in array: bad type or nil == >>>  = "..
						--tostring(all_detected_data[current_size_of_all_detected_data][string_modder_flag]["number_of_detection"])..
						--"; timdetec = "..tostring(all_detected_data[current_size_of_all_detected_data][string_modder_flag]["last_detection_time"])..
						"; str = "..tostring(all_detected_data[current_size_of_all_detected_data][string_modder_flag])..
						"; 0 = "..tostring(all_detected_data[current_size_of_all_detected_data])..
						"; base = "..tostring(all_detected_data)..
						";")
					end
				end
			end
		end

		
		return was_detected_alrdy_or_deleted_or_need_more_details
end


function AngerFunctions.is_player_in_not_allowed_vehicle_for_godmode_scan(pid)
	if player.is_player_in_any_vehicle(pid)  then
		if vehicle.is_vehicle_model(player.get_player_vehicle(pid), HASH_vehicles["minitank"])
		 or vehicle.is_vehicle_model(player.get_player_vehicle(pid), HASH_vehicles["rcbandito"])
		 or vehicle.is_vehicle_model(player.get_player_vehicle(pid), HASH_vehicles["kosatka"])
		then
			--------TESTING
			--[[if vehicle.is_vehicle_model(player.get_player_vehicle(pid), HASH_vehicles["kosatka"])then
				Anger_notify(player.get_player_name(pid).." uses a kosatka", RGBA_to_int32_t(0,255,0,255), 7)
			end
			if vehicle.is_vehicle_model(player.get_player_vehicle(pid), HASH_vehicles["rcbandito"])then
				Anger_notify(player.get_player_name(pid).." uses a rcbandito", RGBA_to_int32_t(0,255,0,255), 7)
			end
			if vehicle.is_vehicle_model(player.get_player_vehicle(pid), HASH_vehicles["minitank"])then
				Anger_notify(player.get_player_name(pid).." uses a minitank", RGBA_to_int32_t(0,255,0,255), 7)
			end]]
			--------TESTING
			
			return true
			
		else
			return false 
		end
	else 
		return false
	end
end





--TODO: look in sougoulizllimaimi
function AngerFunctions.thread_AngerModderDetection()
	local avoid_waiting_if_session_is_started = AngerFunctions.am_i_fully_loaded_in_session(true)   -- true is avoid_waiting_scan (in case you start script direclty from inside lobby)
	
	while true do
		if AngerFunctions.am_i_fully_loaded_in_session(avoid_waiting_if_session_is_started) and User_settings["Anger_Modder_detection_State"] then  
			avoid_waiting_if_session_is_started = true
			
			for pid=0,31 do
				if player.is_player_playing(pid) then
				
					local pid_ped = player.get_player_ped(pid)
					local pid_veh = player.get_player_vehicle(pid)
					-------TESTING
					local speed = AngerFunctions.speed_pid_2D_only(pid)
					-------TESTING
					
					if not entity.is_entity_visible(pid_ped) 
					 or not entity.is_entity_visible(pid_veh)
					then
						player.set_player_visible_locally(pid, true)
						entity.set_entity_visible(pid_veh, true)
					end
					
					--TODO:MAX SPEEED DETECTION
					
					---------TESTING (NOT WORKING PLAYER Z NOT ACTUALIZING (stays -50))
					--if entity.is_entity_visible(pid_ped) 
					--and player.get_player_coords(pid).z < -0.3 
					--then
					--	LogToFile_AngerAnd2T1(player.get_player_name(pid).." is under sea level.")
					--end
					---------TESTING
					
					--check in player uses bandito or minitank or friend
					local continue_analyzing_player_godmode = true
					local continue_analyzing_player_vehiclegodmode = true
					local continue_analyzing_player_health = true
					local continue_analyzing_player_for_modding = true
					
					if User_settings["Anger_GodMode_detection_State"]
					 and((player.is_player_friend(pid) and not User_settings["Anger_GodMode_detection_FriendState"]) 
					 or (player.player_id() == pid and not User_settings["Anger_GodMode_detection_SelfState"])
					 or (not User_settings["Anger_GodMode_detection_State"]))
					then
						continue_analyzing_player_godmode = false
					end
					
					if User_settings["Anger_VehicleGodMode_detection_State"]
					 and((player.is_player_friend(pid) and not User_settings["Anger_VehicleGodMode_detection_FriendState"]) 
					 or (player.player_id() == pid and not User_settings["Anger_VehicleGodMode_detection_SelfState"])
					 or (not User_settings["Anger_VehicleGodMode_detection_State"]))
					then
						continue_analyzing_player_vehiclegodmode = false
					end
					
					if User_settings["Anger_Health_Mod_detection_State"]
					 and((player.is_player_friend(pid) and not User_settings["Anger_Health_Mod_detection_FriendState"]) 
					 or (player.player_id() == pid and not User_settings["Anger_Health_Mod_detection_SelfState"])
					 or (not User_settings["Anger_Health_Mod_detection_State"]))
					then
						continue_analyzing_player_health = false
					end
					
					if AngerFunctions.is_player_in_area_considered_as_NOT_outside(pid)
					 and AngerFunctions.is_player_in_area_considered_as_NOT_outside(pid)
					 and continue_analyzing_player_godmode
					then
						continue_analyzing_player_godmode = false
					end
					
					if User_settings["Anger_Health_Mod_detection_State"]  and continue_analyzing_player_health then
						
						--2500 : beast, 2600 : heavyarmor+minigun, 200: loading, 175 : loading
						if (player.get_player_max_health(pid) > 329 and player.get_player_max_health(pid) ~=2500 and player.get_player_max_health(pid) ~=2600)   
						 or (player.get_player_max_health(pid) < 237 and player.get_player_max_health(pid) ~= 200 and player.get_player_max_health(pid) ~= 175)
						 or player.get_player_health(pid) < 0
						then
							local was_detected_alrdy_or_deleted_or_need_more_details =true
							was_detected_alrdy_or_deleted_or_need_more_details = AngerFunctions.scan_detected_scid(player.get_player_scid(pid), "Ang-HealthMod")
								
								
							if not was_detected_alrdy_or_deleted_or_need_more_details then
								if User_settings["General_Anger_Logging"] and User_settings["Anger_Health_Mod_detection_Logging"] then 
									AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(pid).." have health modification.") 
								end
								if User_settings["General_Anger_Notification"] and User_settings["Anger_Health_Mod_detection_Notification"] then 
									AngerFunctions.Anger_notify(player.get_player_name(pid).." have health modification.", AngerFunctions.RGBA_to_int32_t(255,0,0,255), 7)
								end
								if not player.is_player_friend(pid) and not player.player_id() == pid and User_settings["Anger_Health_Mod_detection_MarkModder"] then
									player.set_player_as_modder(pid, modder_flags["Ang-HealthMod"])
								end
								if not player.is_player_friend(pid) and not player.player_id() == pid and User_settings["Anger_Health_Mod_detection_SaveModder"] then
									AngerFunctions.save_modders_to_file(pid, "Ang-HealthMod")
								end
							end
						end
					end
					
					
					if continue_analyzing_player_for_modding then
						if continue_analyzing_player_godmode and player.is_player_god(pid) then
							
							--TOO MUCH FALSE DETECTION (but working) Primary GM detection (yes i took inspiration ^^' (even if i adapted it))
							--[[if not player.is_player_modder(pid, modder_flags["Ang-Godmode"]) 
							 and User_settings["Anger_GodMode_detection_State"] and player.is_player_god(pid) 
							 and interior.get_interior_from_entity(pid_ped) == 0 
							 and entity.is_entity_visible(pid_ped) --redering needed to be sure of above statements
							then
								if User_settings["General_Anger_Logging"] and User_settings["Anger_GodMode_detection_Logging"] then 
									LogToFile_AngerAnd2T1(player.get_player_name(pid).." is in Godmode (1st method)") 
								end
								if User_settings["General_Anger_Notification"] and User_settings["Anger_GodMode_detection_Notification"] then 
									Anger_notify(player.get_player_name(pid).." is in Godmode. (v1)", RGBA_to_int32_t(255,0,0,255), 7)
								end
								if not player.is_player_friend(pid) and not player.player_id() == pid and User_settings["Anger_GodMode_detection_MarkModder"] then
									player.set_player_as_modder(pid, modder_flags["Ang-Godmode"])
								end
							end]]
							
							--Secondary GM detection (more evolved detection (a bit beyond rendering limits))  (yes i took inspiration ^^' (even if i adapted it))
							if not player.is_player_modder(pid, modder_flags["Ang-Godmode"]) 
							 and User_settings["Anger_GodMode_detection_State"] and player.is_player_god(pid)
							 and AngerFunctions.is_player_ped_really_playing(pid, pid_ped)
							then
								-----TESTING
								if User_settings["Help_My_Dev"] then
									for i=0,800  do
										if i~= AngerLib.data.get_AI_task_id("CTaskGoToPointAnyMeans") and i ~= AngerLib.data.get_AI_task_id("CTaskPlayerIdles") and i ~= AngerLib.data.get_AI_task_id("CTaskSynchronizedScene")
										and i~= AngerLib.data.get_AI_task_id("CTaskUseScenario") and i ~= AngerLib.data.get_AI_task_id("CTaskNMBalance") and i~= AngerLib.data.get_AI_task_id("CTaskUseSequence") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskAmbientClips") and i ~= AngerLib.data.get_AI_task_id("CTaskScriptedAnimation") and i ~= AngerLib.data.get_AI_task_id("CTaskHandsUp") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskVehicleGun") and i ~= AngerLib.data.get_AI_task_id("CTaskVehicleGun") and i ~= AngerLib.data.get_AI_task_id("CTaskAimGunVehicleDriveBy") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskAimGunOnFoot") and i ~= AngerLib.data.get_AI_task_id("CTaskGun") and i ~= AngerLib.data.get_AI_task_id("CTaskSwapWeapon") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskFall") and i ~= AngerLib.data.get_AI_task_id("CTaskPlayerDrive") and i ~= AngerLib.data.get_AI_task_id("CTaskInVehicleBasic") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskInVehicleSeatShuffle") and i ~= AngerLib.data.get_AI_task_id("CTaskFallOver") and i~= AngerLib.data.get_AI_task_id("CTaskFallOver")
										and i ~= AngerLib.data.get_AI_task_id("CTaskOpenVehicleDoorFromOutside") and i ~= AngerLib.data.get_AI_task_id("CTaskNMBuoyancy") and i ~= AngerLib.data.get_AI_task_id("CTaskReloadGun")
										and i ~= AngerLib.data.get_AI_task_id("CTaskNMFlinch") and i ~= AngerLib.data.get_AI_task_id("CTaskTurnToFaceEntityOrCoord") and i ~= AngerLib.data.get_AI_task_id("CTaskDropDown") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskSlopeScramble") and i ~= AngerLib.data.get_AI_task_id("CTaskCover") and i ~= AngerLib.data.get_AI_task_id("CTaskMotionInCover") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskInCover") and i ~= AngerLib.data.get_AI_task_id("CTaskExitVehicleSeat") and i ~= AngerLib.data.get_AI_task_id("CTaskNMRiverRapids") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskClimbLadder") and i ~= AngerLib.data.get_AI_task_id("CTaskAimAndThrowProjectile") and i ~= AngerLib.data.get_AI_task_id("CTaskVault")
										and i ~= AngerLib.data.get_AI_task_id("CTaskExitVehicle") and i ~= AngerLib.data.get_AI_task_id("CTaskEnterVehicle") and i ~= AngerLib.data.get_AI_task_id("CTaskEnterCover")
										and i ~= 423 --[[Unknown]] and i ~= AngerLib.data.get_AI_task_id("CTaskNMDangle") and i ~= AngerLib.data.get_AI_task_id("CTaskGetUp")
										and i ~= AngerLib.data.get_AI_task_id("CTaskParachuteObject") and i ~= AngerLib.data.get_AI_task_id("CTaskFallAndGetUp")
										and ai.is_task_active(pid_ped, i) 
										then AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(pid)..": GM :"..tostring(i)) end
									end
								end
								-----TESTING

								if player.is_player_god(pid)
								 and interior.get_interior_from_entity(pid_ped) == 0
								then
									
									-----TESTING
									--LogToFile_AngerAnd2T1("possible godmode detected")
									-----TESTING
									local was_detected_alrdy_or_deleted_or_need_more_details =true
									was_detected_alrdy_or_deleted_or_need_more_details = AngerFunctions.scan_detected_scid(player.get_player_scid(pid), "Ang-Godmode")
										
										
									if not was_detected_alrdy_or_deleted_or_need_more_details then
										if User_settings["General_Anger_Logging"] and User_settings["Anger_GodMode_detection_Logging"] then 
											AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(pid).." is in Godmode (2nd method)") 
										end
										if User_settings["General_Anger_Notification"] and User_settings["Anger_GodMode_detection_Notification"] then 
											AngerFunctions.Anger_notify(player.get_player_name(pid).." is in Godmode. (v2)", AngerFunctions.RGBA_to_int32_t(255,0,0,255), 7)
										end
										if not player.is_player_friend(pid) and not player.player_id() == pid
										 and User_settings["Anger_GodMode_detection_MarkModder"] 
										then
											player.set_player_as_modder(pid, modder_flags["Ang-Godmode"])
										end
										if not player.is_player_friend(pid) and not player.player_id() == pid and User_settings["Anger_GodMode_detection_SaveModder"] then
											AngerFunctions.save_modders_to_file(pid, "Ang-Godmode")
										end
									end
									
									
								end
							end
							
								--Third GM detection (Speed based)
							if not player.is_player_modder(pid, modder_flags["Ang-Godmode"])		
							 and User_settings["Anger_GodMode_detection_State"] and player.is_player_god(pid)
							 and interior.get_interior_from_entity(pid_ped) == 0
							 and (entity.get_entity_speed(player.get_player_vehicle(pid_ped)) > 8.61112 --31 on 2T1 overlay
							  or entity.get_entity_speed(pid_ped) > 8.61112
							  or AngerFunctions.speed_pid_2D_only(pid) > 8.61112 )
							 --[[and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskGoToPointAnyMeans"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskPlayerIdles"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskSynchronizedScene"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskUseScenario"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskNMBalance"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskUseSequence"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskAmbientClips"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskScriptedAnimation"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskHandsUp"))]]
							then
								-----TESTING
								--LogToFile_AngerAnd2T1("possible godmode detected")
								-----TESTING
								local was_detected_alrdy_or_deleted_or_need_more_details
								was_detected_alrdy_or_deleted_or_need_more_details = AngerFunctions.scan_detected_scid(player.get_player_scid(pid), "Ang-Godmode")
									
								if not was_detected_alrdy_or_deleted_or_need_more_details then
									if User_settings["General_Anger_Logging"] and User_settings["Anger_GodMode_detection_Logging"] then 
										AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(pid).." is in Godmode (3rd method)") 
									end
									if User_settings["General_Anger_Notification"] and User_settings["Anger_GodMode_detection_Notification"] then 
										AngerFunctions.Anger_notify(player.get_player_name(pid).." is in Godmode. (v3)", AngerFunctions.RGBA_to_int32_t(255,0,0,255), 7)
									end
									if not player.is_player_friend(pid) and not player.player_id() == pid 
									 and User_settings["Anger_GodMode_detection_MarkModder"]
									then
										player.set_player_as_modder(pid, modder_flags["Ang-Godmode"])
									end
									if not player.is_player_friend(pid) and not player.player_id() == pid and User_settings["Anger_GodMode_detection_SaveModder"] then
										AngerFunctions.save_modders_to_file(pid, "Ang-Godmode")
									end
								end
							end
							
						--continue_analyzing_player_godmode:endif
						end
							
						if continue_analyzing_player_vehiclegodmode and player.is_player_vehicle_god(pid) then
							--Primary Veh GM detection (took idea from 2nd ped godmdoe detection)
							if not player.is_player_modder(pid, modder_flags["Ang-VehicleGodmode"])
							 and User_settings["Anger_VehicleGodMode_detection_State"] and player.is_player_vehicle_god(pid)
							 and AngerFunctions.is_player_ped_really_playing(pid, pid_ped)
							then

								-------TESTING
								if User_settings["Help_My_Dev"] then
									for i=0,800  do
										if i ~= AngerLib.data.get_AI_task_id("CTaskGoToPointAnyMeans") and i ~= AngerLib.data.get_AI_task_id("CTaskPlayerIdles") and i ~= AngerLib.data.get_AI_task_id("CTaskSynchronizedScene")
										and i~= AngerLib.data.get_AI_task_id("CTaskUseScenario") and i ~= AngerLib.data.get_AI_task_id("CTaskNMBalance") and i~= AngerLib.data.get_AI_task_id("CTaskUseSequence") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskAmbientClips") and i ~= AngerLib.data.get_AI_task_id("CTaskScriptedAnimation") and i ~= AngerLib.data.get_AI_task_id("CTaskHandsUp") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskVehicleGun") and i ~= AngerLib.data.get_AI_task_id("CTaskVehicleGun") and i ~= AngerLib.data.get_AI_task_id("CTaskAimGunVehicleDriveBy") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskAimGunOnFoot") and i ~= AngerLib.data.get_AI_task_id("CTaskGun") and i ~= AngerLib.data.get_AI_task_id("CTaskSwapWeapon") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskFall") and i ~= AngerLib.data.get_AI_task_id("CTaskPlayerDrive") and i ~= AngerLib.data.get_AI_task_id("CTaskInVehicleBasic") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskInVehicleSeatShuffle") and i ~= AngerLib.data.get_AI_task_id("CTaskFallOver") and i~= AngerLib.data.get_AI_task_id("CTaskFallOver")
										and i ~= AngerLib.data.get_AI_task_id("CTaskOpenVehicleDoorFromOutside") and i ~= AngerLib.data.get_AI_task_id("CTaskNMBuoyancy") and i ~= AngerLib.data.get_AI_task_id("CTaskReloadGun")
										and i ~= AngerLib.data.get_AI_task_id("CTaskNMFlinch") and i ~= AngerLib.data.get_AI_task_id("CTaskTurnToFaceEntityOrCoord") and i ~= AngerLib.data.get_AI_task_id("CTaskDropDown") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskSlopeScramble") and i ~= AngerLib.data.get_AI_task_id("CTaskCover") and i ~= AngerLib.data.get_AI_task_id("CTaskMotionInCover") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskInCover") and i ~= AngerLib.data.get_AI_task_id("CTaskExitVehicleSeat") and i ~= AngerLib.data.get_AI_task_id("CTaskNMRiverRapids") 
										and i ~= AngerLib.data.get_AI_task_id("CTaskClimbLadder") and i ~= AngerLib.data.get_AI_task_id("CTaskAimAndThrowProjectile") and i ~= AngerLib.data.get_AI_task_id("CTaskVault")
										and i ~= AngerLib.data.get_AI_task_id("CTaskExitVehicle") and i ~= AngerLib.data.get_AI_task_id("CTaskEnterVehicle") and i ~= AngerLib.data.get_AI_task_id("CTaskEnterCover")
										and i ~= 423 --[[Unknown]] and i ~= AngerLib.data.get_AI_task_id("CTaskNMDangle") and i ~= AngerLib.data.get_AI_task_id("CTaskGetUp")
										and i ~= AngerLib.data.get_AI_task_id("CTaskParachuteObject") and i ~= AngerLib.data.get_AI_task_id("CTaskFallAndGetUp")
										and ai.is_task_active(pid_ped, i) 
										then AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(pid)..": VGM :"..tostring(i)) end
									end
								end
								-------TESTING
								
								-----TESTING
								--LogToFile_AngerAnd2T1("possible godmode detected")
								-----TESTING
								local was_detected_alrdy_or_deleted_or_need_more_details = true
								was_detected_alrdy_or_deleted_or_need_more_details = AngerFunctions.scan_detected_scid(player.get_player_scid(pid), "Ang-VehicleGodmode")
									
								if not was_detected_alrdy_or_deleted_or_need_more_details then
									if User_settings["General_Anger_Logging"] and User_settings["Anger_VehicleGodMode_detection_Logging"] then 
										AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(pid).." has a Vehicle in Godmode (1st method)") 
									end
									if User_settings["General_Anger_Notification"] and User_settings["Anger_VehiclGodMode_detection_Notification"] then 
										AngerFunctions.Anger_notify(player.get_player_name(pid).." has a Vehicle in Godmode. (v1)", AngerFunctions.RGBA_to_int32_t(255,0,0,255), 7)
									end
									if not player.is_player_friend(pid) and not player.player_id() == pid 
									 and User_settings["Anger_VehicleGodMode_detection_MarkModder"]
									then
										player.set_player_as_modder(pid, modder_flags["Ang-VehicleGodmode"])
									end
									if not player.is_player_friend(pid) and not player.player_id() == pid and User_settings["Anger_VehicleGodMode_detection_SaveModder"] then
										AngerFunctions.save_modders_to_file(pid, "Ang-VehicleGodmode")
									end
								end
								
							end
							
							--Secondary Veh GM detection (Speed based)
							if not player.is_player_modder(pid, modder_flags["Ang-VehicleGodmode"])
							 and User_settings["Anger_VehicleGodMode_detection_State"] and player.is_player_vehicle_god(pid) 
							 and (entity.get_entity_speed(ped.get_vehicle_ped_is_using(pid_ped)) > 8.61112 --31 on 2T1 overlay
							  or entity.get_entity_speed(pid_ped) > 8.61112
							  or AngerFunctions.speed_pid_2D_only(pid) > 8.61112 )
							  and pid_ped == vehicle.get_ped_in_vehicle_seat(pid_veh, seats["driver-left_front"])
							 --and interior.get_interior_from_entity(pid_ped) == 0
							 --[[and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskGoToPointAnyMeans"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskPlayerIdles"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskSynchronizedScene"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskUseScenario"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskNMBalance"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskUseSequence"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskAmbientClips"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskScriptedAnimation"))
							 and not ai.is_task_active(pid_ped, AngerLib.data.get_AI_task_id("CTaskHandsUp"))]]
							then
								-----TESTING
								--LogToFile_AngerAnd2T1("possible godmode detected")
								-----TESTING
								local was_detected_alrdy_or_deleted_or_need_more_details
								was_detected_alrdy_or_deleted_or_need_more_details = AngerFunctions.scan_detected_scid(player.get_player_scid(pid), "Ang-VehicleGodmode")
									
								if not was_detected_alrdy_or_deleted_or_need_more_details then
									if User_settings["General_Anger_Logging"] and User_settings["Anger_VehicleGodMode_detection_Logging"] then 
										AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(pid).." has a Vehicle in Godmode (2nd method)") 
									end
									if User_settings["General_Anger_Notification"] and User_settings["Anger_VehiclGodMode_detection_Notification"] then 
										AngerFunctions.Anger_notify(player.get_player_name(pid).." has a Vehicle in Godmode. (v2)", AngerFunctions.RGBA_to_int32_t(255,0,0,255), 7)
									end
									if not player.is_player_friend(pid) and not player.player_id() == pid 
									 and User_settings["Anger_VehicleGodMode_detection_MarkModder"]
									then
										player.set_player_as_modder(pid, modder_flags["Ang-VehicleGodmode"])
									end
									if not player.is_player_friend(pid) and not player.player_id() == pid and User_settings["Anger_VehicleGodMode_detection_SaveModder"] then
										AngerFunctions.save_modders_to_file(pid, "Ang-VehicleGodmode")
									end
								end
							end
						
						--continue_analyzing_player_for_vehiclegodmode:endif
						end
					
					--continue_analyzing_player_for_modding:endif
					end
					
					
					
					
					
					
					system.yield(5) --Avoid freezes, pause the thread for XXX ms and resume(placed in the loop to avoid useless time lost when aiming_player dont corespond to a player in lobby)
				end
			end
		elseif AngerFunctions.am_i_fully_loaded_in_session(true) then
			avoid_waiting_if_session_is_started = false
		end
		system.yield(5) --Avoid freezes/release thread for a bit, pause the thread for XXX ms and resume
	end
end


--[[/***************************** AIMING PROTECTION **********************************************/]]

function AngerFunctions.thread_AimingDetect()
	local avoid_waiting_if_session_is_started = AngerFunctions.am_i_fully_loaded_in_session(true)  -- true is avoid_waiting_scan (in case you start script direclty from inside lobby)

	while true do
		if AngerFunctions.am_i_fully_loaded_in_session(avoid_waiting_if_session_is_started) then  
			avoid_waiting_if_session_is_started = true
			
			-----TESTING
			--LogToFile_AngerAnd2T1("I'm in")
			-----TESTING
			
			for aiming_player = 0,31 do
				if ((player.is_player_god(aiming_player) or player.is_player_vehicle_god(aiming_player))
				 and not AngerFunctions.is_player_in_not_allowed_vehicle_for_godmode_scan(aiming_player) and player.is_player_valid(aiming_player))
				then 
				
					-----TESTING
					--LogToFile_AngerAnd2T1(aiming_player.." is godmode")
					-----TESTING
					local continue_analyzing_player_for_aiming_detection = true
					
					if (player.is_player_friend(aiming_player) and not User_settings["AimingProtection_Godmode_FriendAimingState"]) 
					 or (player.player_id() == aiming_player and not User_settings["AimingProtection_Godmode_SelfState"])
					 or (player.is_player_valid(aiming_player) and not player.player_id() == aiming_player and not player.is_player_friend(aiming_player)
						 and not User_settings["AimingProtection_Godmode_RandomPlayersState"])
					then
						-----TESTING
						--LogToFile_AngerAnd2T1(aiming_player.." is godmode but he should not be analyzed")
						-----TESTING
					
						continue_analyzing_player_for_aiming_detection = false
					end
					
					
					local aimed_entity = player.get_entity_player_is_aiming_at(aiming_player)
					
					if ped.is_ped_a_player(aimed_entity) or entity.is_entity_a_vehicle(aimed_entity) then
						
						-----TESTING
						--LogToFile_AngerAnd2T1("aimed_entity is a vehicle or a player aimed by "..tostring(aiming_player))
						-----TESTING
						
						
						
						-----------WORKS UNTIL HERE
						
						
						
						
						--if the guy at aiming_player is valid
						--if the aimed_entity is a player (no care if not ped i guess)
						--if the aimed_entity is a vehicle used by a player (no care if not vehicle i guess)
						if continue_analyzing_player_for_aiming_detection
						 and (ped.is_ped_a_player(aimed_entity)
						 or ped.is_ped_a_player(vehicle.get_ped_in_vehicle_seat(aimed_entity, seats["any"])))
						then
							
							-----TESTING
							--LogToFile_AngerAnd2T1("aimed_entity is a player_vehicle or a player")
							-----TESTING
							
							--If Anger User is aimed
							if player.get_player_from_ped(aimed_entity) == player.player_id()
							 or player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(aimed_entity, seats["any"])) == player.player_id()
							then
								
								-----TESTING
								--LogToFile_AngerAnd2T1(aiming_player.." is aiming a my_vehicle or a me")
								-----TESTING
								
								if User_settings["General_Anger_Logging"] and User_settings["AimingProtection_Godmode_Logging"] then 
									AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(aiming_player).." is aiming you in godmode")
								end
								if User_settings["General_Anger_Notification"] and User_settings["AimingProtection_Godmode_Notification"] then 
									AngerFunctions.Anger_notify(player.get_player_name(aiming_player).." is aiming you in godmode", AngerFunctions.RGBA_to_int32_t(255,0,0,255), 7)
								end
								
								if not player.is_player_friend(aiming_player) and not player.player_id() == aiming_player 
								 and User_settings["AimingProtection_Godmode_MarkModder"]
								then 
									player.set_player_as_modder(aiming_player, modder_flags["Ang-Godmode-Aiming"])
								end
								if not player.is_player_friend(aiming_player) and not player.player_id() == aiming_player and User_settings["AimingProtection_Godmode_SaveModder"] then
									AngerFunctions.save_modders_to_file(aiming_player, "Ang-Godmode-Aiming")
								end
								
								--OR SPAM GODMODE GUY (not working looks like) force send 3 sms then check if user still aiming me
								--[[local count= 0
								while (count<3 and player.get_entity_player_is_aiming_at(aiming_player) == aimed_entity) or count<5 do 
									count = count +1
									player.send_player_sms(aiming_player, "DON'T SHOOT ME WITH YOUR GODMODE OR YOU NOT GONNA BE HAPPY")
									system.yield(80)  --avoid freeze, and no need to send more
								end]]
								
								--teleport you same 2D/map position but high in air
								entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), player.get_player_coords(player.player_id()) + v3(0, 0, 2000))
								
								--TODO:cage the guy
							end
							
							--if he aims friends in godmode
							if User_settings["AimingProtection_Godmode_FriendAimedState"] == true 
							 and (player.is_player_friend(player.get_player_from_ped(aimed_entity)) 
							  or player.is_player_friend(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(aimed_entity, seats["any"]))))
							then
								
								-----TESTING
								--LogToFile_AngerAnd2T1(aiming_player.." is aiming a friend_vehicle or a friend")
								-----TESTING
								
								if User_settings["General_Anger_Logging"] and User_settings["AimingProtection_Godmode_Logging"] then 
									AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(aiming_player).." is aiming your friend "..
									player.get_player_name(player.get_player_from_ped(aimed_entity)).." in godmode") 
								end
								if User_settings["General_Anger_Notification"] and User_settings["AimingProtection_Godmode_Notification"] then 
									AngerFunctions.Anger_notify(player.get_player_name(aiming_player).." is aiming your friend "..
									player.get_player_name(player.get_player_from_ped(aimed_entity)).." in godmode", AngerFunctions.RGBA_to_int32_t(255,0,0,255), 7)
								end
								
								if not player.is_player_friend(aiming_player) and not player.player_id() == aiming_player 
								 and User_settings["AimingProtection_Godmode_MarkModder"]
								then 
									player.set_player_as_modder(aiming_player, modder_flags["Ang-Godmode-Aiming"])
								end
								if not player.is_player_friend(aiming_player) and not player.player_id() == aiming_player 
								 and User_settings["AimingProtection_Godmode_SaveModder"] 
								then
									AngerFunctions.save_modders_to_file(aiming_player, "Ang-Godmode-Aiming")
								end


								if User_settings["AimingProtection_Godmode_SMSFriendAimedState"] then
									--send sms to aimed friend
									player.send_player_sms(player.get_player_from_ped(aimed_entity), player.get_player_name(aiming_player).." is aiming you in godmode")
								end
						
								--OR SPAM GODMODE GUY (not working looks like) force send 3 sms then check if user still aiming friend
								--[[local count= 0
								while (count<3 and player.get_entity_player_is_aiming_at(aiming_player) == aimed_entity) or count<5 do 
									count = count +1
									player.send_player_sms(aiming_player, "DON'T SHOOT MY FRIENDS WITH YOUR GODMODE OR YOU NOT GONNA BE HAPPY")
									system.yield(80)  --avoid freeze, and no need to send more
								end]]
								
								--teleport friend same 2D/map position but high in air
								local friend_vehicle = player.get_player_vehicle(player.get_player_from_ped(aimed_entity))
								if friend_vehicle and User_settings["AimingProtection_Godmode_TeleportFriendAimedState"] then
									AngerFunctions.request_ctrl_of_entity(friend_vehicle, 1800)
									entity.set_entity_coords_no_offset(friend_vehicle, player.get_player_coords(player.get_player_from_ped(aimed_entity)) + v3(0, 0, 2000))
								end
								
								--TODO:cage the guy
							end
							
							--if he aims someone in godmode
							if player.is_player_valid(player.get_player_from_ped(aimed_entity))
							 or player.is_player_valid(player.get_player_from_ped(vehicle.get_ped_in_vehicle_seat(aimed_entity, seats["any"])))
							then
								
								-----TESTING
								--LogToFile_AngerAnd2T1(aiming_player.." is aiming a player_vehicle or a player")
								-----TESTING
								
								if User_settings["General_Anger_Logging"] and User_settings["AimingProtection_Godmode_Logging"] then 
									AngerFunctions.LogToFile_AngerAnd2T1(player.get_player_name(aiming_player).." is aiming this guy : "..
									player.get_player_name(player.get_player_from_ped(aimed_entity)).." in godmode") 
								end
								if User_settings["General_Anger_Notification"] and User_settings["AimingProtection_Godmode_Notification"] then 
									AngerFunctions.Anger_notify(player.get_player_name(aiming_player).." is aiming this guy : "..
									player.get_player_name(player.get_player_from_ped(aimed_entity)).." in godmode", AngerFunctions.RGBA_to_int32_t(255,0,0,255), 7)
								end
								
								if not player.is_player_friend(aiming_player) and not player.player_id() == aiming_player 
								 and User_settings["AimingProtection_Godmode_MarkModder"]
								then 
									player.set_player_as_modder(aiming_player, modder_flags["Ang-Godmode-Aiming"])
								end
								if not player.is_player_friend(aiming_player) and not player.player_id() == aiming_player 
								 and User_settings["AimingProtection_Godmode_SaveModder"] 
								then
									AngerFunctions.save_modders_to_file(aiming_player, "Ang-Godmode-Aiming")
								end
								
								--send sms to aimed friend
								--player.send_player_sms(player.get_player_from_ped(aimed_entity), player.get_player_name(aiming_player).." is aiming you in godmode")
						
								--OR SPAM GODMODE GUY (not working looks like) force send 3 sms then check if user still aiming friend
								--[[local count= 0
								while (count<3 and player.get_entity_player_is_aiming_at(aiming_player) == aimed_entity) or count<5 do 
									count = count +1
									player.send_player_sms(aiming_player, "DON'T SHOOT MY FRIENDS WITH YOUR GODMODE OR YOU NOT GONNA BE HAPPY")
									system.yield(80)  --avoid freeze, and no need to send more
								end]]
								
								--teleport this guy same 2D/map position but high in air
								--[[local friend_vehicle = player.get_player_vehicle(player.get_player_from_ped(aimed_entity))
								if friend_vehicle then
									AngerFunctions.request_control_of_entity(friend_vehicle, 1800)
									entity.set_entity_coords_no_offset(friend_vehicle, player.get_player_coords(player.get_player_from_ped(aimed_entity)) + v3(0, 0, 2000))
								end]]
								
								--TODO:cage the guy
							end
								
						end
					end
				end
			system.yield(0) --Avoid freezes, pause the thread for XXX ms and resume
			end
			
		elseif AngerFunctions.am_i_fully_loaded_in_session(true) == false then
			avoid_waiting_if_session_is_started = false
		end
		system.yield(0) --Avoid freezes/release thread for a bit, pause the thread for XXX ms and resume
	end
end










--[[/*****************************(parent) FEATURES FOLDER MANAGMENT / SETTINGS **********************************************/]]

--User_settings names have to be the same as AngerFeatures.with_toggle & with_valuei

AngerFeatures.PlayerFeatures = {}
AngerFeatures.with_toggle = {}
AngerFeatures.with_value = {}  --none for now but surely in future (save_settings and get_saved_settings implemented alrdy)

-----GENERAL FOLDER
AngerFeatures.generalfolder = menu.add_feature("Anger Features", "parent", 0)

-----AIM PROTECTION FOLDERS
AngerFeatures.AimingUserFriendsProtectionFolder = menu.add_feature("Yourself/Friend Aim Protection", "parent", AngerFeatures.generalfolder.id)
AngerFeatures.GodmodeAimingProtection = menu.add_feature("Godmode Aim Protection", "parent", AngerFeatures.AimingUserFriendsProtectionFolder.id)

-----MODDER DETECTION FOLDERS
AngerFeatures.AngerModderDetectionFolder = menu.add_feature("Modder Detection", "parent", AngerFeatures.generalfolder.id)
AngerFeatures.AngerGodmodeDetectionFolder = menu.add_feature("Godmode Detection", "parent", AngerFeatures.AngerModderDetectionFolder.id)
AngerFeatures.AngerHealthDetectionFolder = menu.add_feature("Health Modification Detection", "parent", AngerFeatures.AngerModderDetectionFolder.id)
AngerFeatures.AngerVehicleGodmodeDetectionFolder = menu.add_feature("Vehicle Godmode Detection", "parent", AngerFeatures.AngerModderDetectionFolder.id)
AngerFeatures.AngerNAMEspoofingDetectionFolder = menu.add_feature("Name Spoofing Detection", "parent", AngerFeatures.AngerModderDetectionFolder.id)
AngerFeatures.AngerRIDspoofingDetectionFolder = menu.add_feature("RID Spoofing Detection", "parent", AngerFeatures.AngerModderDetectionFolder.id)
AngerFeatures.AngerIPspoofingDetectionFolder = menu.add_feature("IP Spoofing Detection", "parent", AngerFeatures.AngerModderDetectionFolder.id)
AngerFeatures.AngerHOSTTOKENspoofingDetectionFolder = menu.add_feature("Host Token Spoofing Detection", "parent", AngerFeatures.AngerModderDetectionFolder.id)

-----SAVED PLAYERS FOLDERS
AngerFeatures.AngerSavePlayersFolder = menu.add_feature("Saved Players", "parent", AngerFeatures.generalfolder.id)


-----ANGER MISC FOLDER
AngerFeatures.AngerMiscFolder = menu.add_feature("Misc", "parent", AngerFeatures.generalfolder.id)


-----ANGER SETTINGS FOLDER
AngerFeatures.AngerSettingsFolder = menu.add_feature("Settings", "parent", AngerFeatures.generalfolder.id)




-----ANGER PLAYER FEATURES FOLDERS
AngerFeatures.PlayerFeatures.generalfolder = menu.add_player_feature("Anger Features", "parent", 0)
AngerFeatures.PlayerFeatures.SE_Folder = menu.add_player_feature("Script Events", "parent", AngerFeatures.PlayerFeatures.generalfolder.id)
AngerFeatures.PlayerFeatures.vehicle_Folder = menu.add_player_feature("Vehicle", "parent", AngerFeatures.PlayerFeatures.generalfolder.id)
AngerFeatures.PlayerFeatures.Vehicle = {}



--[[/*****************************(parent) PLAYER FEATURES MANAGMENT / SETTINGS BUTTON  **********************************************/]]

--[[   :  EXEMPLE  :
--add a group of PlayerFeat.feats[32] handled with thefeature.id (see get_player_feature below)
local thefeature = menu.add_player_feature("Something", "autoaction_value_i", 0, function(feat, slot)
    --DO SOMTHING
end)

--get the specific player feature of player 'pid' with : get_player_feature(feature_id).feats (.feats = property of PlayerFeat type)
 menu.get_player_feature(thefeature.id).feats[pid].value = the_value
 ]]



	--[[
	
OTHER / DOOR FUNCTIONS VEHICLE : 

#### Ped				get_ped_in_vehicle_seat(Vehicle vehicle, int seat)
#### bool				is_vehicle_full(Vehicle vehicle)
#### int				get_free_seat(Vehicle vehicle)

#### bool				is_vehicle_stopped(Vehicle veh)
#### void				set_vehicle_stolen(Vehicle vehicle, bool toggle)
#### void				set_vehicle_fixed(Vehicle veh)
#### void				set_vehicle_tire_fixed(Vehicle veh, int idx)
#### void				set_vehicle_bulletproof_tires(Vehicle veh, bool toggle)
#### void				set_vehicle_deformation_fixed(Vehicle veh)
#### void				set_vehicle_undriveable(Vehicle veh, bool toggle)
#### bool				set_vehicle_on_ground_properly(Vehicle veh)
#### bool				is_vehicle_on_all_wheels(Vehicle veh)
#### bool				is_vehicle_stuck_on_roof(Vehicle veh)
#### void				set_vehicle_can_be_locked_on(Vehicle veh, bool toggle, bool skipSomeCheck)
#### float				get_vehicle_estimated_max_speed(Vehicle veh)

#### void				set_vehicle_door_open(Vehicle veh, int doorIndex, bool loose, bool openInstantly)
#### void				set_vehicle_doors_shut(Vehicle veh, bool closeInstantly)
#### bool				set_vehicle_doors_locked(Vehicle vehicle, int lockStatus)
#### void				set_vehicle_doors_locked_for_player(Vehicle veh, Player player, bool toggle)
#### bool				get_vehicle_doors_locked_for_player(Vehicle veh, Player player)
#### void				set_vehicle_doors_locked_for_all_players(Vehicle veh, bool toggle)
#### void				set_vehicle_doors_locked_for_non_script_players(Vehicle veh, bool toggle)
#### void				set_vehicle_doors_locked_for_team(Vehicle veh, int32_t team, bool toggle)

#### void				set_vehicle_tires_can_burst(Vehicle veh, bool toggle)
#### void				set_vehicle_tire_burst(Vehicle veh, int index, bool onRim, float unk0)
#### bool				is_vehicle_engine_running(Vehicle veh)
#### void				set_vehicle_engine_health(Vehicle veh, float health)
#### bool				is_vehicle_damaged(Vehicle veh)
#### Vehicle			create_vehicle(Hash model, v3 pos, float heading, bool networked, bool alwaysFalse)

#### void				set_vehicle_density_multipliers_this_frame(float mult)
#### void				set_random_vehicle_density_multiplier_this_frame(float mult)
#### void				set_parked_vehicle_density_multiplier_this_frame(float mult)
#### void				set_ambient_vehicle_range_multiplier_this_frame(float mult)

#### bool				is_vehicle_rocket_boost_active(Vehicle veh)
#### void				set_vehicle_rocket_boost_active(Vehicle veh, bool toggle)
#### void				set_vehicle_rocket_boost_percentage(Vehicle veh, float percentage)
#### void				set_vehicle_rocket_boost_refill_time(Vehicle veh, float refillTime)

#### int32_t			get_vehicle_number_of_passengers(Vehicle veh)
#### int32_t			get_vehicle_max_number_of_passengers(Vehicle veh)
#### int32_t			get_vehicle_model_number_of_seats(Hash modelHash)

#### bool				is_vehicle_model(Vehicle veh, Hash model)

#### void				set_vehicle_out_of_control(Vehicle veh, bool killDriver, bool explodeOnImpact)

#### void				explode_vehicle(Vehicle veh, bool isAudible, bool isInvisible)
#### void				set_vehicle_timed_explosion(Vehicle veh, Ped ped, bool toggle)
#### void				add_vehicle_phone_explosive_device(Vehicle veh)
#### bool				has_vehicle_phone_explosive_device()
#### void				detonate_vehicle_phone_explosive_device()

#### void				set_taxi_lights(Vehicle veh, bool state)
#### bool				is_taxi_light_on(Vehicle veh)

#### Hash[]				get_all_vehicle_model_hashes()
#### Vehicle[]			get_all_vehicles()

#### void				modify_vehicle_top_speed(Vehicle veh, float f)
#### void				set_vehicle_engine_torque_multiplier_this_frame(Vehicle veh, float f)
#### void				set_vehicle_forward_speed(Vehicle veh, float speed)

#### void				set_heli_blades_full_speed(Vehicle v)
#### void				set_heli_blades_speed(Vehicle v, float speed)

#### void				set_vehicle_parachute_active(Vehicle v, bool toggle)
#### bool				does_vehicle_have_parachute(Vehicle v)
#### bool				can_vehicle_parachute_be_activated(Vehicle v)

#### bool				get_vehicle_has_been_owned_by_player(Vehicle veh)
#### bool				set_vehicle_has_been_owned_by_player(Vehicle veh, bool owned)

#### int|nil			get_vehicle_current_gear(Vehicle veh)
#### bool				set_vehicle_current_gear(Vehicle veh, int gear)
#### int|nil			get_vehicle_next_gear(Vehicle veh)
#### bool				set_vehicle_next_gear(Vehicle veh, int gear)
#### int|nil			get_vehicle_max_gear(Vehicle veh)
#### bool				set_vehicle_max_gear(Vehicle veh, int gear)
#### float|nil			get_vehicle_gear_ratio(Vehicle veh, int gear)
#### bool				set_vehicle_gear_ratio(Vehicle veh, int gear, float ratio)
#### float|nil			get_vehicle_rpm(Vehicle veh)
#### float|nil			get_vehicle_steer_bias(Vehicle veh)
#### bool				set_vehicle_steer_bias(Vehicle veh, float v)

#### bool				get_vehicle_reduce_grip(Vehicle veh)
#### bool				set_vehicle_reduce_grip(Vehicle veh, bool t)

#### int|nil			get_vehicle_wheel_count(Vehicle veh)
#### float|nil			get_vehicle_wheel_tire_radius(Vehicle veh, int idx)
#### float|nil			get_vehicle_wheel_rim_radius(Vehicle veh, int idx)
#### float|nil			get_vehicle_wheel_tire_width(Vehicle veh, int idx)
#### float|nil			get_vehicle_wheel_rotation_speed(Vehicle veh, int idx)
#### bool				set_vehicle_wheel_tire_radius(Vehicle veh, int idx, float v)
#### bool				set_vehicle_wheel_rim_radius(Vehicle veh, int idx, float v)
#### bool				set_vehicle_wheel_tire_width(Vehicle veh, int idx, float v)
#### bool				set_vehicle_wheel_rotation_speed(Vehicle veh, int idx, float v)
#### float|nil			get_vehicle_wheel_render_size(Vehicle veh)
#### bool				set_vehicle_wheel_render_size(Vehicle veh, float size)
#### float|nil			get_vehicle_wheel_render_width(Vehicle veh)
#### bool				set_vehicle_wheel_render_width(Vehicle veh, float width)
#### float|nil			get_vehicle_wheel_power(Vehicle veh, int idx)
#### bool				set_vehicle_wheel_power(Vehicle veh, int idx, float v)
#### float|nil			get_vehicle_wheel_health(Vehicle veh, int idx)
#### bool				set_vehicle_wheel_health(Vehicle veh, int idx, float v)
#### float|nil			get_vehicle_wheel_brake_pressure(Vehicle veh, int idx)
#### bool				set_vehicle_wheel_brake_pressure(Vehicle veh, int idx, float v)
#### float|nil			get_vehicle_wheel_traction_vector_length(Vehicle veh, int idx)
#### bool				set_vehicle_wheel_traction_vector_length(Vehicle veh, int idx, float v)
#### float|nil			get_vehicle_wheel_x_offset(Vehicle veh, int idx)
#### bool				set_vehicle_wheel_x_offset(Vehicle veh, int idx, float v)
#### float|nil			get_vehicle_wheel_y_rotation(Vehicle veh, int idx)
#### bool				set_vehicle_wheel_y_rotation(Vehicle veh, int idx, float v)
#### int				get_vehicle_wheel_flags(Vehicle veh, int idx)
#### bool				set_vehicle_wheel_flags(Vehicle veh, int idx, int v)
#### bool				set_vehicle_wheel_is_powered(Vehicle veh, int idx, int v)

#### int|nil			get_vehicle_class(Vehicle veh)
#### string|nil			get_vehicle_class_name(Vehicle veh)
#### string|nil			get_vehicle_brand(Vehicle veh)
#### string|nil			get_vehicle_model(Vehicle veh)
#### string|nil			get_vehicle_brand_label(Vehicle veh)
#### string|nil			get_vehicle_model_label(Vehicle veh)




STYLISM / VISUAL / WHEELS / LandingGear / ENGINE :

#### void				set_vehicle_tire_smoke_color(Vehicle vehicle, int r, int g, int b)

#### bool				set_vehicle_color(Vehicle v, BYTE p, BYTE s, BYTE pearl, BYTE wheel)

#### string				get_mod_text_label(Vehicle veh, int modType, int modValue)
#### string				get_mod_slot_name(Vehicle veh, int modType)
#### int				get_num_vehicle_mods(Vehicle veh, int modType)
#### bool				set_vehicle_mod(Vehicle vehicle, int modType, int modIndex, bool customTires)
#### int				get_vehicle_mod(Vehicle vehicle, int modType)
#### bool				set_vehicle_mod_kit_type(Vehicle vehicle, int type)

#### void				set_vehicle_extra(Vehicle veh, int extra, bool toggle)
#### bool				does_extra_exist(Vehicle veh, int extra)
#### bool				is_vehicle_extra_turned_on(Vehicle veh, int extra)

#### void				toggle_vehicle_mod(Vehicle veh, int mod, bool toggle)
#### bool				is_toggle_mod_on(Vehicle veh, int index)

#### bool				is_vehicle_a_convertible(Vehicle veh)
#### bool				get_convertible_roof_state(Vehicle veh)
#### void				set_convertible_roof(Vehicle veh, bool toggle)

#### void				set_vehicle_indicator_lights(Vehicle veh, int index, bool toggle)
#### void				set_vehicle_brake_lights(Vehicle veh, bool toggle)

#### void				set_vehicle_can_be_visibly_damaged(Vehicle veh, bool toggle)

#### void				set_vehicle_engine_on(Vehicle veh, bool toggle, bool instant, bool noAutoTurnOn)

#### void				set_vehicle_number_plate_text(Vehicle veh, string text)
#### void				set_vehicle_wheel_type(Vehicle veh, int type)
#### void				set_vehicle_number_plate_index(Vehicle veh, int index)
#### int 				get_num_vehicle_mod(Vehicle veh, int modType)

#### bool				set_vehicle_neon_lights_color(Vehicle vehicle, int color)
#### int				get_vehicle_neon_lights_color(Vehicle vehicle)
#### bool				set_vehicle_neon_light_enabled(Vehicle vehicle, int index, bool toggle)
#### bool				is_vehicle_neon_light_enabled(Vehicle vehicle, int index, bool toggle)

#### void				control_landing_gear(Vehicle veh, int32_t state)
#### int32_t			get_landing_gear_state(Vehicle veh)

#### int32_t			get_vehicle_livery(Vehicle veh)
#### bool				set_vehicle_livery(Vehicle veh, int32_t index)
#### string				get_livery_name(Vehicle veh, int32_t livery)

#### int32_t			get_vehicle_livery_count(Vehicle veh)
#### int32_t			get_vehicle_roof_livery_count(Vehicle veh)

#### bool				set_vehicle_colors(Vehicle veh, int32_t primary, int32_t secondary)
#### bool				set_vehicle_extra_colors(Vehicle veh, int32_t pearl, int32_t wheel)

#### int32_t			get_vehicle_primary_color(Vehicle veh)
#### int32_t			get_vehicle_secondary_color(Vehicle veh)
#### int32_t			get_vehicle_pearlecent_color(Vehicle veh)
#### int32_t			get_vehicle_wheel_color(Vehicle veh)

#### bool				set_vehicle_fullbeam(Vehicle veh, bool toggle)

#### void				set_vehicle_custom_primary_colour(Vehicle veh, uint32_t color)
#### uint32_t			get_vehicle_custom_primary_colour(Vehicle veh)
#### void				clear_vehicle_custom_primary_colour(Vehicle veh)
#### bool				is_vehicle_primary_colour_custom(Vehicle veh)

#### void				set_vehicle_custom_secondary_colour(Vehicle veh, uint32_t color)
#### uint32_t			get_vehicle_custom_secondary_colour(Vehicle veh)
#### void				clear_vehicle_custom_secondary_colour(Vehicle veh)
#### bool				is_vehicle_secondary_colour_custom(Vehicle veh)

#### void				set_vehicle_custom_pearlescent_colour(Vehicle veh, uint32_t color)
#### uint32_t			get_vehicle_custom_pearlescent_colour(Vehicle veh)
#### void				set_vehicle_custom_wheel_colour(Vehicle veh, uint32_t color)
#### uint32_t			get_vehicle_custom_wheel_colour(Vehicle veh)


#### void				set_vehicle_window_tint(Vehicle veh, int32_t t)
#### int32_t			get_vehicle_window_tint(Vehicle veh)


#### int32_t			get_vehicle_headlight_color(Vehicle v)
#### bool				set_vehicle_headlight_color(Vehicle v, int32_t color)


]]

AngerFeatures.PlayerFeatures.Vehicle.Clone = menu.add_player_feature("Clone", "action", AngerFeatures.PlayerFeatures.vehicle_Folder.id, function(feat, pid)
	-----TESTING
	AngerFunctions.LogToFile_AngerAnd2T1(tostring(player.get_player_vehicle(pid)).." vehicle id")
	-----TESTING
	
	streaming.request_model(gameplay.get_hash_key("krieger"))
	local timeout = utils.time_ms()
	local pid_veh = player.get_player_vehicle(pid)
	while streaming.has_model_loaded(entity.get_entity_model_hash(pid_veh)) == false and utils.time_ms()-timeout < 500 do end
    local spawned_veh = vehicle.create_vehicle(entity.get_entity_model_hash(pid_veh), player.get_player_coords(player.player_id()), 
						player.get_player_heading(player.player_id()), true, false)
	
	vehicle.set_vehicle_custom_primary_colour(spawned_veh, vehicle.get_vehicle_custom_primary_colour(pid_veh))
	vehicle.set_vehicle_custom_secondary_colour(spawned_veh, vehicle.get_vehicle_custom_secondary_colour(pid_veh))
	vehicle.set_vehicle_custom_pearlescent_colour(spawned_veh, vehicle.get_vehicle_custom_pearlescent_colour(pid_veh))
	vehicle.set_vehicle_custom_wheel_colour(spawned_veh, vehicle.get_vehicle_custom_wheel_colour(pid_veh))

	--[[vehicle.set_vehicle_color(spawned_veh, vehicle.get_vehicle_primary_color(pid_veh), 
						vehicle.get_vehicle_secondary_color(pid_veh), 
						vehicle.get_vehicle_pearlecent_color(pid_veh), 
						vehicle.get_vehicle_wheel_color(pid_veh))]]


	--[[local mod_count = 0
	local timeout = utils.time_ms()
	while vehicle.get_vehicle_mod(pid_veh, mod_count) ~= nil and utils.time_ms() - timeout < 1500 do 


		-----TESTING
		LogToFile_AngerAnd2T1(tostring(vehicle.get_vehicle_mod(pid_veh, mod_count)).." vehicle mod for mod_count ="..tostring(mod_count))
		-----TESTING


		vehicle.set_vehicle_mod(spawned_veh, mod_count, vehicle.get_vehicle_mod(pid_veh, mod_count), true)

		mod_count = mod_count + 1;

	end]]

	---TEST WITH ARENA VEHICLE
	
end)

AngerFeatures.PlayerFeatures.Vehicle.Repair = menu.add_player_feature("Repair", "action", AngerFeatures.PlayerFeatures.vehicle_Folder.id, function(feat, pid)
	-----TESTING
	--AngerFunctions.LogToFile_AngerAnd2T1(tostring(player.get_player_vehicle(pid)).." vehicle id")
	-----TESTING
	
	
	local pid_veh = player.get_player_vehicle(pid)
	
	

	--no need control
	vehicle.set_vehicle_fixed(pid_veh)
	vehicle.set_vehicle_deformation_fixed(pid_veh)

	--no need control
	--vehicle.set_vehicle_tire_fixed(Vehicle veh, int idx)
	vehicle.set_vehicle_tire_fixed(pid_veh, idx_vehicle_wheels.FrontLeft)
	vehicle.set_vehicle_tire_fixed(pid_veh, idx_vehicle_wheels.FrontRight)
	vehicle.set_vehicle_tire_fixed(pid_veh, idx_vehicle_wheels.MiddleRight)
	vehicle.set_vehicle_tire_fixed(pid_veh, idx_vehicle_wheels.MiddleLeft)
	vehicle.set_vehicle_tire_fixed(pid_veh, idx_vehicle_wheels.BackLeft)
	vehicle.set_vehicle_tire_fixed(pid_veh, idx_vehicle_wheels.BackRight)
	vehicle.set_vehicle_tire_fixed(pid_veh, idx_vehicle_wheels.SecondMidRight)
	vehicle.set_vehicle_tire_fixed(pid_veh, idx_vehicle_wheels.SecondMidLeft)
		
	

	if not vehicle.is_vehicle_engine_running(pid_veh) then

		AngerFunctions.request_ctrl_of_entity(pid_veh, 1800)

		--vehicle.set_vehicle_engine_health(Vehicle veh, float health)
		vehicle.set_vehicle_engine_health(pid_veh, 1000.00)

		--vehicle.set_vehicle_engine_on(Vehicle veh, bool toggle, bool instant, bool noAutoTurnOn)
		vehicle.set_vehicle_engine_on(pid_veh, true, true, false)

	end


	--couldnt make it work quickly
	--vehicle.set_vehicle_undriveable(Vehicle veh, bool toggle)
	vehicle.set_vehicle_undriveable(pid_veh, false)

end)

AngerFeatures.PlayerFeatures.Vehicle.Engine_Fire = menu.add_player_feature("Make Vehicle Two Bullet Before In Fire", "action", AngerFeatures.PlayerFeatures.vehicle_Folder.id, function(feat, pid)

	local pid_veh = player.get_player_vehicle(pid)

	AngerFunctions.request_ctrl_of_entity(pid_veh, 1800)

	vehicle.set_vehicle_engine_health(pid_veh, -0.99999999)
end)

AngerFeatures.PlayerFeatures.Vehicle.Engine_Fire = menu.add_player_feature("Make Vehicle In Fire (Break Personnal Vehicle) [TO TEST] ", "action", AngerFeatures.PlayerFeatures.vehicle_Folder.id, function(feat, pid)

	local pid_veh = player.get_player_vehicle(pid)

	AngerFunctions.request_ctrl_of_entity(pid_veh, 1800)

	vehicle.set_vehicle_engine_health(pid_veh, -1.1)
end)

AngerFeatures.PlayerFeatures.Vehicle.Engine_Kill = menu.add_player_feature("Kill Engine (Break Personnal Vehicle)", "action", AngerFeatures.PlayerFeatures.vehicle_Folder.id, function(feat, pid)

	local pid_veh = player.get_player_vehicle(pid)

	AngerFunctions.request_ctrl_of_entity(pid_veh, 1800)

	vehicle.set_vehicle_engine_health(pid_veh, -4000.00)
end)

AngerFeatures.PlayerFeatures.Vehicle.Engine_Max_Health = menu.add_player_feature("Max Engine Health", "action", AngerFeatures.PlayerFeatures.vehicle_Folder.id, function(feat, pid)

	local pid_veh = player.get_player_vehicle(pid)

	AngerFunctions.request_ctrl_of_entity(pid_veh, 1800)

	vehicle.set_vehicle_engine_health(pid_veh, 1000.00)
end)

AngerFeatures.PlayerFeatures.Vehicle.Engine_Off = menu.add_player_feature("Turn Engine Off", "action", AngerFeatures.PlayerFeatures.vehicle_Folder.id, function(feat, pid)

	local pid_veh = player.get_player_vehicle(pid)

	AngerFunctions.request_ctrl_of_entity(pid_veh, 1800)

	--vehicle.set_vehicle_engine_on(Vehicle veh, bool toggle, bool instant, bool noAutoTurnOn)
	vehicle.set_vehicle_engine_on(pid_veh, false, true, true)
end)

AngerFeatures.PlayerFeatures.Vehicle.Engine_On = menu.add_player_feature("Turn Engine On", "action", AngerFeatures.PlayerFeatures.vehicle_Folder.id, function(feat, pid)

	local pid_veh = player.get_player_vehicle(pid)

	AngerFunctions.request_ctrl_of_entity(pid_veh, 1800)

	--vehicle.set_vehicle_engine_on(Vehicle veh, bool toggle, bool instant, bool noAutoTurnOn)
	vehicle.set_vehicle_engine_on(pid_veh, true, true, false)
end)

AngerFeatures.PlayerFeatures.Vehicle.Engine_Always_On = menu.add_player_feature("Engine Stays On when player isn't driving", "action", AngerFeatures.PlayerFeatures.vehicle_Folder.id, function(feat, pid)

	local pid_veh = player.get_player_vehicle(pid)

	AngerFunctions.request_ctrl_of_entity(pid_veh, 1800)

	--vehicle.set_vehicle_engine_on(Vehicle veh, bool toggle, bool instant, bool noAutoTurnOn)
	vehicle.set_vehicle_engine_on(pid_veh, true, true, true)
end)













menu.add_player_feature("Test SE", "action", 0, function(feat, pid)
	--for i = 0, 31 do
		AngerFunctions.send_SE(pid, SE_hashes.testy)
			--   disable_jumping:NOT WORKING  transaction_failed:WORKING    bounty:WORKING    
			--	anonymous_bounty:WORKING  CEO_10k:NOT WORKING  CEO_30k:NOT WORKING
			--	   CEO_ban   CEO_terminate   CEO_dismiss
	--end
end)

menu.add_player_feature("Test SE loop 50 ms", "toggle", 0, function(feat, pid)
	while feat.on do
		--send_SE(18, SE_hashes.vehicle_kick[1])
		AngerFunctions.send_SE(0, SE_hashes.crash[1])
		system.yield(50)
	end 
end)





menu.add_player_feature("Block Passive", "toggle", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	if feat.on then
		AngerFunctions.send_SE(pid, SE_hashes.block_passive, true)
	else
		AngerFunctions.send_SE(pid, SE_hashes.block_passive, false)
	end
end)

menu.add_player_feature("Put Player in BlackScreen (Appart Inv)", "toggle", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	while feat.on do
		AngerFunctions.send_SE(pid, SE_hashes.invalid_appartment_invite)
		system.yield(10)
	end
end)

menu.add_player_feature("Send To Cayo Island", "toggle", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	while feat.on do
		AngerFunctions.send_SE(pid, SE_hashes.send_island)
		system.yield(10)
	end
end)

menu.add_player_feature("Bring Back / Random Appartment Invite", "action", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	if feat.on then
		AngerFunctions.send_SE(pid, SE_hashes.appartment_invite, 2)
	end
end)

menu.add_player_feature("Force Player To Random Mission", "toggle", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	while feat.on do
		AngerFunctions.send_SE(pid, SE_hashes.force_mission)
		system.yield(10)
	end
end)

menu.add_player_feature("CEO / MC Ban", "action", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	while feat.on do
		AngerFunctions.send_SE(pid, SE_hashes.CEO_MC_ban)
		system.yield(10)
	end
end)

menu.add_player_feature("Kick From Vehicle", "toggle", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	while feat.on do
		AngerFunctions.send_SE(pid, SE_hashes.vehicle_kick)
		system.yield(10)
	end
end)

menu.add_player_feature("Send Transaction Failed", "toggle", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	while feat.on do
		AngerFunctions.send_SE(pid, SE_hashes.transaction_failed)
		system.yield(10)
	end
end)

menu.add_player_feature("Bounty", "action", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	while feat.on do
		for i = 0, 31 do
			AngerFunctions.send_SE(i, SE_hashes.bounty, 
				AngerFunctions.get_user_input("Enter Bounty Amount (Min : 0$ ,  Max:10'000$ )","9000", 5,int_INPUT_TYPES.NUM)
									,pid )
			system.yield(10)
		end
	end
end)

menu.add_player_feature("Anonymous Bounty", "action", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	while feat.on do
		for i = 0, 31 do
			AngerFunctions.send_SE(i, SE_hashes.anonymous_bounty, 
				AngerFunctions.get_user_input("Enter Bounty Amount (Min : 0$ ,  Max:10'000$ )","9000", 5,int_INPUT_TYPES.NUM)
									,pid )
			system.yield(10)
		end
	end
end)

menu.add_player_feature("Off Radar", "toggle", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	while feat.on do
		AngerFunctions.send_SE(pid, SE_hashes.off_radar)
		system.yield(10)
	end
end)

menu.add_player_feature("Never Wanted", "toggle", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	while feat.on do
		AngerFunctions.send_SE(pid, SE_hashes.clear_cop)
		system.yield(10)
	end
end)

menu.add_player_feature("Send Insurance Fraud", "toggle", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	while feat.on do
		AngerFunctions.send_SE(pid, SE_hashes.insurance_fraud)
		system.yield(10)
	end
end)

menu.add_player_feature("SE Kick", "toggle", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	while feat.on do
		AngerFunctions.send_SE(pid, SE_hashes.kick)
		AngerFunctions.send_SE(pid, SE_hashes.blackscreen_kick)
		system.yield(10)
	end
end)

menu.add_player_feature("SE Crash", "toggle", AngerFeatures.PlayerFeatures.SE_Folder.id, function(feat, pid)
	while feat.on do
		AngerFunctions.send_SE(pid, SE_hashes.crash)
		system.yield(10)
	end
end)


--[[/*****************************(parent) FEATURES MANAGMENT / SETTINGS BUTTON **********************************************/]]


----GENERAL MODDER DETECT
AngerFeatures.with_toggle["Anger_Modder_detection_State"] = menu.add_feature("Activate Modder Detection", "toggle", AngerFeatures.AngerModderDetectionFolder.id, function(feature)
	if feature.on then
		Anger_threads["Anger_Modder_detection"] = menu.create_thread(AngerFunctions.thread_AngerModderDetection, 0)
		User_settings["Anger_Modder_detection_State"] = true
	else
		menu.delete_thread(Anger_threads["AngerModderDetect"])
		User_settings["Anger_Modder_detection_State"] = false
		-- maybe needed to empty all_detected_data
	end
end)


---- VEHICLE GODMODE DETECT
AngerFeatures.with_toggle["Anger_VehiclGodMode_detection_Notification"] = menu.add_feature("Notification from Godmode Detection", "toggle", AngerFeatures.AngerVehicleGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_VehiclGodMode_detection_Notification"] = true
	else
		User_settings["Anger_VehiclGodMode_detection_Notification"] = false
	end
end)

AngerFeatures.with_toggle["Anger_VehicleGodMode_detection_Logging"] = menu.add_feature("Log Notification from Godmode Detection", "toggle", AngerFeatures.AngerVehicleGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_VehicleGodMode_detection_Logging"] = true
	else
		User_settings["Anger_VehicleGodMode_detection_Logging"] = false
	end
end)

AngerFeatures.with_toggle["Anger_VehicleGodMode_detection_MarkModder"] = menu.add_feature("Mark as Modder in User InfoBox", "toggle", AngerFeatures.AngerVehicleGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_VehicleGodMode_detection_MarkModder"] = true
	else
		User_settings["Anger_VehicleGodMode_detection_MarkModder"] = false
	end
end)

AngerFeatures.with_toggle["Anger_VehicleGodMode_detection_SaveModder"] = menu.add_feature("Save Modder in Files", "toggle", AngerFeatures.AngerVehicleGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_VehicleGodMode_detection_SaveModder"] = true
	else
		User_settings["Anger_VehicleGodMode_detection_SaveModder"] = false
	end
end)

AngerFeatures.with_toggle["Anger_VehicleGodMode_detection_FriendState"] = menu.add_feature("Activate Detection for friends", "toggle", AngerFeatures.AngerVehicleGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_VehicleGodMode_detection_FriendState"] = true
	else
		User_settings["Anger_VehicleGodMode_detection_FriendState"] = false
	end
end)

AngerFeatures.with_toggle["Anger_VehicleGodMode_detection_SelfState"] = menu.add_feature("Activate Detection for Yourself", "toggle", AngerFeatures.AngerVehicleGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_VehicleGodMode_detection_SelfState"] = true
	else
		User_settings["Anger_VehicleGodMode_detection_SelfState"] = false
	end
end)

AngerFeatures.with_toggle["Anger_VehicleGodMode_detection_State"] = menu.add_feature("Activate Godmode Detection", "toggle", AngerFeatures.AngerVehicleGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_VehicleGodMode_detection_State"] = true
	else
		User_settings["Anger_VehicleGodMode_detection_State"] = false
	end
end)



----GODMODE DETECT
AngerFeatures.with_toggle["Anger_GodMode_detection_Notification"] = menu.add_feature("Notification from Godmode Detection", "toggle", AngerFeatures.AngerGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_GodMode_detection_Notification"] = true
	else
		User_settings["Anger_GodMode_detection_Notification"] = false
	end
end)

AngerFeatures.with_toggle["Anger_GodMode_detection_Logging"] = menu.add_feature("Log Notification from Godmode Detection", "toggle", AngerFeatures.AngerGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_GodMode_detection_Logging"] = true
	else
		User_settings["Anger_GodMode_detection_Logging"] = false
	end
end)

AngerFeatures.with_toggle["Anger_GodMode_detection_MarkModder"] = menu.add_feature("Mark as Modder in User InfoBox", "toggle", AngerFeatures.AngerGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_GodMode_detection_MarkModder"] = true
	else
		User_settings["Anger_GodMode_detection_Logging"] = false
	end
end)

AngerFeatures.with_toggle["Anger_GodMode_detection_SaveModder"] = menu.add_feature("Save Modder in Files", "toggle", AngerFeatures.AngerGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_GodMode_detection_SaveModder"] = true
	else
		User_settings["Anger_GodMode_detection_SaveModder"] = false
	end
end)

AngerFeatures.with_toggle["Anger_GodMode_detection_FriendState"] = menu.add_feature("Activate Detection for friends", "toggle", AngerFeatures.AngerGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_GodMode_detection_FriendState"] = true
	else
		User_settings["Anger_GodMode_detection_FriendState"] = false
	end
end)

AngerFeatures.with_toggle["Anger_GodMode_detection_SelfState"] = menu.add_feature("Activate Detection for Yourself", "toggle", AngerFeatures.AngerGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_GodMode_detection_SelfState"] = true
	else
		User_settings["Anger_GodMode_detection_SelfState"] = false
	end
end)

AngerFeatures.with_toggle["Anger_GodMode_detection_State"] = menu.add_feature("Activate Godmode Detection", "toggle", AngerFeatures.AngerGodmodeDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_GodMode_detection_State"] = true
	else
		User_settings["Anger_GodMode_detection_State"] = false
	end
end)


----HEALTH MODIFICATION DETECT
AngerFeatures.with_toggle["Anger_Health_Mod_detection_Notification"] = menu.add_feature("Notification from Health Mod Detection", "toggle", AngerFeatures.AngerHealthDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_Health_Mod_detection_Notification"] = true
	else
		User_settings["Anger_Health_Mod_detection_Notification"] = false
	end
end)


AngerFeatures.with_toggle["Anger_Health_Mod_detection_Logging"] = menu.add_feature("Log Notification from Health Mod Detection", "toggle", AngerFeatures.AngerHealthDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_Health_Mod_detection_Logging"] = true
	else
		User_settings["Anger_Health_Mod_detection_Logging"] = false
	end
end)

AngerFeatures.with_toggle["Anger_Health_Mod_detection_MarkModder"] = menu.add_feature("Mark as Modder in User InfoBox", "toggle", AngerFeatures.AngerHealthDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_Health_Mod_detection_MarkModder"] = true
	else
		User_settings["Anger_Health_Mod_detection_MarkModder"] = false
	end
end)

AngerFeatures.with_toggle["Anger_Health_Mod_detection_SaveModder"] = menu.add_feature("Save Modder in Files", "toggle", AngerFeatures.AngerHealthDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_Health_Mod_detection_SaveModder"] = true
	else
		User_settings["Anger_Health_Mod_detection_SaveModder"] = false
	end
end)

AngerFeatures.with_toggle["Anger_Health_Mod_detection_FriendState"] = menu.add_feature("Activate Detection for friends", "toggle", AngerFeatures.AngerHealthDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_Health_Mod_detection_FriendState"] = true
	else
		User_settings["Anger_Health_Mod_detection_FriendState"] = false
	end
end)

AngerFeatures.with_toggle["Anger_Health_Mod_detection_SelfState"] = menu.add_feature("Activate Detection for Yourself", "toggle", AngerFeatures.AngerHealthDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_Health_Mod_detection_SelfState"] = true
	else
		User_settings["Anger_Health_Mod_detection_SelfState"] = false
	end
end)

AngerFeatures.with_toggle["Anger_Health_Mod_detection_State"] = menu.add_feature("Activate Health Mod Detection", "toggle", AngerFeatures.AngerHealthDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_Health_Mod_detection_State"] = true
	else
		User_settings["Anger_Health_Mod_detection_State"] = false
	end
end)



---NAME SPOOFING DETECTION
AngerFeatures.with_toggle["Anger_NAME_Spoof_detection_Notification"] = menu.add_feature("Notification from Name Spoof Detection", "toggle", AngerFeatures.AngerNAMEspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_NAME_Spoof_detection_Notification"] = true
	else
		User_settings["Anger_NAME_Spoof_detection_Notification"] = false
	end
end)

AngerFeatures.with_toggle["Anger_NAME_Spoof_detection_Logging"] = menu.add_feature("Log Notification from Name Spoof Detection", "toggle", AngerFeatures.AngerNAMEspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_NAME_Spoof_detection_Logging"] = true
	else
		User_settings["Anger_NAME_Spoof_detection_Logging"] = false
	end
end)

AngerFeatures.with_toggle["Anger_NAME_Spoof_detection_MarkModder"] = menu.add_feature("Mark as Modder in User InfoBox", "toggle", AngerFeatures.AngerNAMEspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_NAME_Spoof_detection_MarkModder"] = true
	else
		User_settings["Anger_NAME_Spoof_detection_MarkModder"] = false
	end
end)

AngerFeatures.with_toggle["Anger_NAME_Spoof_detection_SaveModder"] = menu.add_feature("Save Modder in Files", "toggle", AngerFeatures.AngerNAMEspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_NAME_Spoof_detection_SaveModder"] = true
	else
		User_settings["Anger_NAME_Spoof_detection_SaveModder"] = false
	end
end)

AngerFeatures.with_toggle["Anger_NAME_Spoof_detection_FriendState"] = menu.add_feature("Activate Detection for friends", "toggle", AngerFeatures.AngerNAMEspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_NAME_Spoof_detection_FriendState"] = true
	else
		User_settings["Anger_NAME_Spoof_detection_FriendState"] = false
	end
end)

AngerFeatures.with_toggle["Anger_NAME_Spoof_detection_SelfState"] = menu.add_feature("Activate Detection for Yourself", "toggle", AngerFeatures.AngerNAMEspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_NAME_Spoof_detection_SelfState"] = true
	else
		User_settings["Anger_NAME_Spoof_detection_SelfState"] = false
	end
end)

AngerFeatures.with_toggle["Anger_NAME_Spoof_detection_State"] = menu.add_feature("Activate Name Spoofing Detection", "toggle", AngerFeatures.AngerNAMEspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_NAME_Spoof_detection_State"] = true

	else
		User_settings["Anger_NAME_Spoof_detection_State"] = false
	end
end)

---RID SPOOFING DETECTION
AngerFeatures.with_toggle["Anger_RID_Spoof_detection_Notification"] = menu.add_feature("Notification from RID Spoof Detection", "toggle", AngerFeatures.AngerRIDspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_RID_Spoof_detection_Notification"] = true
	else
		User_settings["Anger_RID_Spoof_detection_Notification"] = false
	end
end)

AngerFeatures.with_toggle["Anger_RID_Spoof_detection_Logging"] = menu.add_feature("Log Notification from RID Spoof Detection", "toggle", AngerFeatures.AngerRIDspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_RID_Spoof_detection_Logging"] = true
	else
		User_settings["Anger_RID_Spoof_detection_Logging"] = false
	end
end)

AngerFeatures.with_toggle["Anger_RID_Spoof_detection_MarkModder"] = menu.add_feature("Mark as Modder in User InfoBox", "toggle", AngerFeatures.AngerRIDspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_RID_Spoof_detection_MarkModder"] = true
	else
		User_settings["Anger_RID_Spoof_detection_MarkModder"] = false
	end
end)

AngerFeatures.with_toggle["Anger_RID_Spoof_detection_SaveModder"] = menu.add_feature("Save Modder in Files", "toggle", AngerFeatures.AngerRIDspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_RID_Spoof_detection_SaveModder"] = true
	else
		User_settings["Anger_RID_Spoof_detection_SaveModder"] = false
	end
end)

AngerFeatures.with_toggle["Anger_RID_Spoof_detection_FriendState"] = menu.add_feature("Activate Detection for friends", "toggle", AngerFeatures.AngerRIDspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_RID_Spoof_detection_FriendState"] = true
	else
		User_settings["Anger_RID_Spoof_detection_FriendState"] = false
	end
end)

AngerFeatures.with_toggle["Anger_RID_Spoof_detection_SelfState"] = menu.add_feature("Activate Detection for Yourself", "toggle", AngerFeatures.AngerRIDspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_RID_Spoof_detection_SelfState"] = true
	else
		User_settings["Anger_RID_Spoof_detection_SelfState"] = false
	end
end)

AngerFeatures.with_toggle["Anger_RID_Spoof_detection_State"] = menu.add_feature("Activate RID Spoofing Detection", "toggle", AngerFeatures.AngerRIDspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_RID_Spoof_detection_State"] = true

	else
		User_settings["Anger_RID_Spoof_detection_State"] = false
	end
end)

---IP SPOOFING DETECTION
AngerFeatures.with_toggle["Anger_IP_Spoof_detection_Notification"] = menu.add_feature("Notification from IP Spoof Detection", "toggle", AngerFeatures.AngerIPspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_IP_Spoof_detection_Notification"] = true
	else
		User_settings["Anger_IP_Spoof_detection_Notification"] = false
	end
end)

AngerFeatures.with_toggle["Anger_IP_Spoof_detection_Logging"] = menu.add_feature("Log Notification from IP Spoof Detection", "toggle", AngerFeatures.AngerIPspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_IP_Spoof_detection_Logging"] = true
	else
		User_settings["Anger_IP_Spoof_detection_Logging"] = false
	end
end)

AngerFeatures.with_toggle["Anger_IP_Spoof_detection_MarkModder"] = menu.add_feature("Mark as Modder in User InfoBox", "toggle", AngerFeatures.AngerIPspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_IP_Spoof_detection_MarkModder"] = true
	else
		User_settings["Anger_IP_Spoof_detection_MarkModder"] = false
	end
end)

AngerFeatures.with_toggle["Anger_IP_Spoof_detection_SaveModder"] = menu.add_feature("Save Modder in Files", "toggle", AngerFeatures.AngerIPspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_IP_Spoof_detection_SaveModder"] = true
	else
		User_settings["Anger_IP_Spoof_detection_SaveModder"] = false
	end
end)

AngerFeatures.with_toggle["Anger_IP_Spoof_detection_FriendState"] = menu.add_feature("Activate Detection for friends", "toggle", AngerFeatures.AngerIPspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_IP_Spoof_detection_FriendState"] = true
	else
		User_settings["Anger_IP_Spoof_detection_FriendState"] = false
	end
end)

AngerFeatures.with_toggle["Anger_IP_Spoof_detection_SelfState"] = menu.add_feature("Activate Detection for Yourself", "toggle", AngerFeatures.AngerIPspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_IP_Spoof_detection_SelfState"] = true
	else
		User_settings["Anger_IP_Spoof_detection_SelfState"] = false
	end
end)


AngerFeatures.with_toggle["Anger_IP_Spoof_detection_State"] = menu.add_feature("Activate IP Spoofing Detection", "toggle", AngerFeatures.AngerIPspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_IP_Spoof_detection_State"] = true

	else
		User_settings["Anger_IP_Spoof_detection_State"] = false
	end
end)


---HOST TOKEN SPOOFING DETECTION
AngerFeatures.with_toggle["Anger_HOST_TOKEN_Spoof_detection_Notification"] = menu.add_feature("Notification from Host-T Spoof Detection", "toggle", AngerFeatures.AngerHOSTTOKENspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_HOST_TOKEN_Spoof_detection_Notification"] = true
	else
		User_settings["Anger_HOST_TOKEN_Spoof_detection_Notification"] = false
	end
end)

AngerFeatures.with_toggle["Anger_HOST_TOKEN_Spoof_detection_Logging"] = menu.add_feature("Log Notification from Host-T Spoof Detection", "toggle", AngerFeatures.AngerHOSTTOKENspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_HOST_TOKEN_Spoof_detection_Logging"] = true
	else
		User_settings["Anger_HOST_TOKEN_Spoof_detection_Logging"] = false
	end
end)

AngerFeatures.with_toggle["Anger_HOST_TOKEN_Spoof_detection_MarkModder"] = menu.add_feature("Mark as Modder in User InfoBox", "toggle", AngerFeatures.AngerHOSTTOKENspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_HOST_TOKEN_Spoof_detection_MarkModder"] = true
	else
		User_settings["Anger_HOST_TOKEN_Spoof_detection_MarkModder"] = false
	end
end)

AngerFeatures.with_toggle["Anger_HOST_TOKEN_Spoof_detection_SaveModder"] = menu.add_feature("Save Modder in Files", "toggle", AngerFeatures.AngerHOSTTOKENspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_HOST_TOKEN_Spoof_detection_SaveModder"] = true
	else
		User_settings["Anger_HOST_TOKEN_Spoof_detection_SaveModder"] = false
	end
end)

AngerFeatures.with_toggle["Anger_HOST_TOKEN_Spoof_detection_FriendState"] = menu.add_feature("Activate Detection for friends", "toggle", AngerFeatures.AngerHOSTTOKENspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_HOST_TOKEN_Spoof_detection_FriendState"] = true
	else
		User_settings["Anger_HOST_TOKEN_Spoof_detection_FriendState"] = false
	end
end)

AngerFeatures.with_toggle["Anger_HOST_TOKEN_Spoof_detection_SelfState"] = menu.add_feature("Activate Detection for Yourself", "toggle", AngerFeatures.AngerHOSTTOKENspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_HOST_TOKEN_Spoof_detection_SelfState"] = true
	else
		User_settings["Anger_HOST_TOKEN_Spoof_detection_SelfState"] = false
	end
end)


AngerFeatures.with_toggle["Anger_HOST_TOKEN_Spoof_detection_State"] = menu.add_feature("Activate Host-T Spoofing Detection", "toggle", AngerFeatures.AngerHOSTTOKENspoofingDetectionFolder.id, function(feature)
	if feature.on then
		User_settings["Anger_HOST_TOKEN_Spoof_detection_State"] = true

	else
		User_settings["Anger_HOST_TOKEN_Spoof_detection_State"] = false
	end
end)



----SAVED PLAYERS
--TODO







------ AIMING PROTECTION GODMDOE
--FOLDERS : 
AngerFeatures.GodmodeAimingProtection_Folder_Friend_Related = menu.add_feature("Friend Related Detections", "parent", AngerFeatures.GodmodeAimingProtection.id, nil)

--OTHERS:
AngerFeatures.with_toggle["AimingProtection_Godmode_Notification"] = menu.add_feature("Notification from Godmode Aim Protection", "toggle", AngerFeatures.GodmodeAimingProtection.id, function(feature)
    
	if feature.on then
		User_settings["AimingProtection_Godmode_Notification"] = true
	else
		User_settings["AimingProtection_Godmode_Notification"] = false
	end
end)

AngerFeatures.with_toggle["AimingProtection_Godmode_Logging"] = menu.add_feature("Log from Godmode Aim Protection", "toggle", AngerFeatures.GodmodeAimingProtection.id, function(feature)
    
	if feature.on then
		User_settings["AimingProtection_Godmode_Logging"] = true
	else
		User_settings["AimingProtection_Godmode_Logging"] = false
	end
	
end)

AngerFeatures.with_toggle["AimingProtection_Godmode_MarkModder"] = menu.add_feature("Mark as Modder in User InfoBox", "toggle", AngerFeatures.GodmodeAimingProtection.id, function(feature)
	if feature.on then
		User_settings["AimingProtection_Godmode_MarkModder"] = true
	else
		User_settings["AimingProtection_Godmode_MarkModder"] = false
	end
end)

AngerFeatures.with_toggle["AimingProtection_Godmode_SaveModder"] = menu.add_feature("Save Modder in Files", "toggle", AngerFeatures.GodmodeAimingProtection.id, function(feature)
	if feature.on then
		User_settings["AimingProtection_Godmode_SaveModder"] = true
	else
		User_settings["AimingProtection_Godmode_SaveModder"] = false
	end
end)


AngerFeatures.with_toggle["AimingProtection_Godmode_FriendAimingState"] = menu.add_feature("Activate for Friends Aiming in Godmode", "toggle", AngerFeatures.GodmodeAimingProtection_Folder_Friend_Related.id, function(feature)
    
	if feature.on then
		User_settings["AimingProtection_Godmode_FriendAimingState"] = true
		
	else
		User_settings["AimingProtection_Godmode_FriendAimingState"] = false
	end
	
end)

AngerFeatures.with_toggle["AimingProtection_Godmode_FriendAimedState"] = menu.add_feature("Activate for Friends Aimed in Godmode", "toggle", AngerFeatures.GodmodeAimingProtection_Folder_Friend_Related.id, function(feature)
    
	if feature.on then
		User_settings["AimingProtection_Godmode_FriendAimedState"] = true
		
	else
		User_settings["AimingProtection_Godmode_FriendAimedState"] = false
	end
	
end)


AngerFeatures.with_toggle["AimingProtection_Godmode_SMSFriendAimedState"] = menu.add_feature("Send SMS to Friends Aimed in Godmode", "toggle", AngerFeatures.GodmodeAimingProtection_Folder_Friend_Related.id, function(feature)

	if feature.on then
		User_settings["AimingProtection_Godmode_SMSFriendAimedState"] = true
	else
		User_settings["AimingProtection_Godmode_SMSFriendAimedState"] = false
	end

end)


AngerFeatures.with_toggle["AimingProtection_Godmode_TeleportFriendAimedState"] = menu.add_feature("Teleport Friends Aimed in Godmode", "toggle", AngerFeatures.GodmodeAimingProtection_Folder_Friend_Related.id, function(feature)
    
	if feature.on then
		User_settings["AimingProtection_Godmode_TeleportFriendAimedState"] = true
		
	else
		User_settings["AimingProtection_Godmode_TeleportFriendAimedState"] = false
	end
	
end)


AngerFeatures.with_toggle["AimingProtection_Godmode_SelfState"] = menu.add_feature("Activate Detection for Yourself", "toggle", AngerFeatures.GodmodeAimingProtection.id, function(feature)
	if feature.on then
		User_settings["AimingProtection_Godmode_SelfState"] = true
	else
		User_settings["AimingProtection_Godmode_SelfState"] = false
	end
end)

AngerFeatures.with_toggle["AimingProtection_Godmode_RandomPlayersState"] = menu.add_feature("Activate Detection for Random Players", "toggle", AngerFeatures.GodmodeAimingProtection.id, function(feature)
	if feature.on then
		User_settings["AimingProtection_Godmode_RandomPlayersState"] = true
	else
		User_settings["AimingProtection_Godmode_RandomPlayersState"] = false
	end
end)

AngerFeatures.with_toggle["AimingProtection_Godmode_State"] = menu.add_feature("Activate Godmode Aim Protection", "toggle", AngerFeatures.GodmodeAimingProtection.id, function(feature)
    
	if feature.on then
		Anger_threads["DetectGMaiming"] = menu.create_thread(AngerFunctions.thread_AimingDetect, 0)
		User_settings["AimingProtection_Godmode_State"] = true
	else
		menu.delete_thread(Anger_threads["DetectGMaiming"])
		User_settings["AimingProtection_Godmode_State"] = false
	end
	
end)

----GENERAL MISC
--

AngerFeatures.with_toggle["Max_MentalState_State"] = menu.add_feature("Enable \"Maximum allowed mental state\"", "toggle", AngerFeatures.AngerMiscFolder.id, function(feature)
    
	if feature.on then
		User_settings["Max_MentalState_State"] = true
	else
		User_settings["Max_MentalState_State"] = false
	end
	
end)


--[[AngerFeatures.with_value["Max_MentalState_value"] = menu.add_feature("Maximum allowed mental state value :", "autoaction_value_f", AngerFeatures.AngerMiscFolder.id, function(feature)
	User_settings["Max_MentalState_value"] = feature.value
end)
AngerFeatures.with_value["Max_MentalState_value"].max = 100  --1:Anger; 2:2T1; 3: Big Skull; 4: small skull
AngerFeatures.with_value["Max_MentalState_value"].min = 0  --0:none
AngerFeatures.with_value["Max_MentalState_value"].mod = 0.5]]



----GENERAL SETTINGS
AngerFeatures.SaveMyConfig = menu.add_feature("Save Actual Configuration", "action", AngerFeatures.AngerSettingsFolder.id, function(feature)
    if feature.on then
		local SavedConfig_Init = false
		AngerFunctions.save_settings()
	end
end)




-- *********************************** ANGER NOTIFY FEATURES DECLARATION  *******************************--
------ DEVELOPPER CHOICES : If you desire moving this section, you can do it 
-- ========== >>>>>>>>>     BUT KEEP THE SECTION UNDER THE "require("Anger_notify")"       <<<<<<< ==========

------ DEVELOPPER CHOICES : If you desire saving user parameter/settings, you can in the below section
-- ========== >>>>>>>>>   And check the parameter of  "AngerLib.notify.get_notification_features_for_settings"   <<<<<<< ==========
--[[if utils.file_exists(path_Anger_notifyLUA) then
		
		------DEVELOPPER CHOICES
		local FEAT_id_main_parent_settings = AngerFeatures.AngerSettings.id  --  <===  DEVELOPPER INPUT
		local BOOL_display_Anger_notify_settings_in_main_parent_setting_featurefolder = false   --bug with false
		local saved_setting_for_Anger_Better_Notifications_State = User_settings["General_Anger_Better_Notifications_State"]
		local saved_setting_for_Anger_Better_Notifications_X = User_settings["General_Anger_Better_Notifications_X"]
		local saved_setting_for_Anger_Better_Notifications_X = User_settings["General_Anger_Better_Notifications_Y"]
		------END DEVELOPPER CHOICES
		
		
		local FEAT_id_parent_to_use
		if BOOL_display_Anger_notify_settings_in_main_parent_setting_featurefolder then
			FEAT_id_parent_to_use = FEAT_id_main_parent_settings
		else
			FEAT_id_parent_to_use = menu.add_feature("Anger Better Notifications Settings", "parent", FEAT_id_main_parent_settings, nil)
		end
		
		--nothing to save for this one
		AngerFeatures.with_toggle["General_Anger_Better_Notifications_Visual_Settings"] = menu.add_feature("Enable Overlay for Easier Settings", "toggle", FEAT_id_parent_to_use.id, nil)
		--end nothing to save for this one
		
		AngerFeatures.with_valuei["General_Anger_Better_Notifications_X"] = menu.add_feature("Notifications X ([%], left to right)", "autoaction_value_f", FEAT_id_parent_to_use.id, function(feature)
			User_settings["General_Anger_Better_Notifications_X"] = feature.value
			--Add a AngerLib.notify.modiy_notification_style("General_Anger_Better_Notifications_X", feature.value)
		end)
		AngerFeatures.with_valuei["General_Anger_Better_Notifications_X"].min = 0
		AngerFeatures.with_valuei["General_Anger_Better_Notifications_X"].max = 1
		AngerFeatures.with_valuei["General_Anger_Better_Notifications_X"].mod = 0.05
		
		AngerFeatures.with_valuei["General_Anger_Better_Notifications_Y"] = menu.add_feature("Notifications Y ([%], left to right)", "autoaction_value_f", FEAT_id_parent_to_use.id, function(feature)
			User_settings["General_Anger_Better_Notifications_Y"] = feature.value
		end)
		AngerFeatures.with_valuei["General_Anger_Better_Notifications_Y"].min = 0
		AngerFeatures.with_valuei["General_Anger_Better_Notifications_Y"].max = 1
		AngerFeatures.with_valuei["General_Anger_Better_Notifications_Y"].mod = 0.05
		
		--Add setting general : scale based on foot size, that would keep maybe same test length for occupied area
		
		--Give to lib features and User_Settings value etc...
		AngerLib.notify.get_notification_features_for_settings(AngerFeatures.with_toggle["General_Anger_Better_Notifications_State"],
															   saved_setting_for_Anger_Better_Notifications_State)
		
		------------------ ANGER BETTER NOTIFICATIONS ACTIVATION -----------------
		AngerFeatures.with_toggle["General_Anger_Better_Notifications_State"] = menu.add_feature("Enable Anger Better Notifications", "toggle", FEAT_id_parent_to_use.id, AngerLib.notify.d3d_draw_better_notifications)
		------------------ ANGER BETTER NOTIFICATIONS ACTIVATION -----------------
end]]


------------------------------------------------------------------------------------------------------------
--************************************* END ANGER NOTIFY FEATURES DECLARATION ********************************



AngerFeatures.with_toggle["General_Anger_Notification"] = menu.add_feature("Accept Notifications from Anger Features", "toggle", AngerFeatures.AngerSettingsFolder.id, function(feature)
    
	if feature.on then
		User_settings["General_Anger_Notification"] = true
	else 
		User_settings["General_Anger_Notification"] = false
	end
	
end)

AngerFeatures.with_toggle["General_Anger_Notification_Title"] = menu.add_feature("Make Every Anger Notifications with Title", "toggle", AngerFeatures.AngerSettingsFolder.id, function(feature)
    
	if feature.on then
		User_settings["General_Anger_Notification_Title"] = true
		if utils.time_ms() - START_UP_TIME_MS > 2000 then
			AngerFunctions.Anger_notify("With Title (Above)", AngerFunctions.RGBA_to_int32_t(0,255,255,255),5)
		end
	else 
		User_settings["General_Anger_Notification_Title"] = false
		if utils.time_ms() - START_UP_TIME_MS > 2000 then
			AngerFunctions.Anger_notify("Without Title (Above)", AngerFunctions.RGBA_to_int32_t(0,255,255,255),5)
		end
	end
	
end)

AngerFeatures.with_toggle["General_Anger_Logging"] = menu.add_feature("Accept Logging from Anger Features", "toggle", AngerFeatures.AngerSettingsFolder.id, function(feature)
    
	if feature.on then
		User_settings["General_Anger_Logging"] = true
	else
		User_settings["General_Anger_Logging"] = false
	end
		
end)

AngerFeatures.with_toggle["General_Anger_Log_in_2T1notif_file"] = menu.add_feature("Log in 2T1 notif file directly", "toggle", AngerFeatures.AngerSettingsFolder.id, function(feature)
    
	if feature.on then
		User_settings["General_Anger_Log_in_2T1notif_file"] = true
	else
		User_settings["General_Anger_Log_in_2T1notif_file"] = false
	end
		
end)

--[[AngerFeatures.with_toggle["General_2T1_Logging"] = menu.add_feature("Log Everything from 2T1", "toggle", AngerFeatures.AngerSettings.id, function(feature)
    
	if feature.on then
		Anger_threads["Log_2T1"] = menu.create_thread(thread_log2T1, 0)
		User_settings["General_2T1_Logging"] = true
	else
		menu.delete_thread(Anger_threads["Log_2T1"])
		User_settings["General_2T1_Logging"] = false
	end
	
end)]]

AngerFeatures.with_toggle["Session_Host_Migration_Logging"] = menu.add_feature("Log Session Host Migration", "toggle", AngerFeatures.AngerSettingsFolder.id, function(feature)
    
	if feature.on then
		User_settings["Session_Host_Migration_Logging"] = true
		--it's on good news youhou (checked in leving_player_event_listener)
	else
		User_settings["Session_Host_Migration_Logging"] = false
	end
	
end)

AngerFeatures.with_toggle["Session_Host_Migration_Notification"] = menu.add_feature("Notify Session Host Migration", "toggle", AngerFeatures.AngerSettingsFolder.id, function(feature)
    
	if feature.on then
		User_settings["Session_Host_Migration_Notification"] = true
		--it's on good news youhou (checked in leving_player_event_listener)
	else
		User_settings["Session_Host_Migration_Notification"] = false
	end
	
end)

AngerFeatures.with_toggle["Script_Host_Migration_Logging"] = menu.add_feature("Log Script Host Migration", "toggle", AngerFeatures.AngerSettingsFolder.id, function(feature)
    
	if feature.on then
		User_settings["Script_Host_Migration_Logging"] = true
		
		if Anger_threads["Any_Host_Migration"] ~= nil then
			if menu.has_thread_finished(Anger_threads["Any_Host_Migration"]) then
				Anger_threads["Any_Host_Migration"] = menu.create_thread(AngerFunctions.thread_scan_Script_Host_Migration, 0)
			end
			--(half also checked in leving_player_event_listener)
		else
			Anger_threads["Any_Host_Migration"] = menu.create_thread(AngerFunctions.thread_scan_Script_Host_Migration, 0)
		end
	else
		if Anger_threads["Any_Host_Migration"] ~= nil then
			if not menu.has_thread_finished(Anger_threads["Any_Host_Migration"]) then
				menu.delete_thread(Anger_threads["Any_Host_Migration"])
			end
		end
		User_settings["Script_Host_Migration_Logging"] = false
	end
	
end)

AngerFeatures.with_toggle["Script_Host_Migration_Notification"] = menu.add_feature("Notify Script Host Migration", "toggle", AngerFeatures.AngerSettingsFolder.id, function(feature)
    
	if feature.on then
		User_settings["Script_Host_Migration_Notification"] = true
		
		if Anger_threads["Any_Host_Migration"] ~= nil then
			if menu.has_thread_finished(Anger_threads["Any_Host_Migration"]) then
				Anger_threads["Any_Host_Migration"] = menu.create_thread(AngerFunctions.thread_scan_Script_Host_Migration, 0)
			end
			--(half also checked in leving_player_event_listener)
		else
			Anger_threads["Any_Host_Migration"] = menu.create_thread(AngerFunctions.thread_scan_Script_Host_Migration, 0)
		end
	else
		if Anger_threads["Any_Host_Migration"] ~= nil then
			if not menu.has_thread_finished(Anger_threads["Any_Host_Migration"]) then
				menu.delete_thread(Anger_threads["Any_Host_Migration"])
			end
		end
		User_settings["Script_Host_Migration_Notification"] = false
	end
	
end)


AngerFeatures.with_toggle["Chat_Logging"] = menu.add_feature("Log Everything from chat", "toggle", AngerFeatures.AngerSettingsFolder.id, function(feature)
    
	if feature.on then
		User_settings["Chat_Logging"] = true
		--it's on good news youhou (checked in leving_player_event_listener)
	else
		User_settings["Chat_Logging"] = false
	end
	
end)


AngerFeatures.with_value["ASCII_drawing"] = menu.add_feature("Choose ASCII drawing in logs", "autoaction_value_i", AngerFeatures.AngerSettingsFolder.id, function(feature)
	User_settings["ASCII_drawing"] = feature.value
end)
AngerFeatures.with_value["ASCII_drawing"].max = 4  --1:Anger; 2:2T1; 3: Big Skull; 4: small skull
AngerFeatures.with_value["ASCII_drawing"].min = 0  --0:none
AngerFeatures.with_value["ASCII_drawing"].mod = 1
menu.add_feature("    0: None | 1: Anger | 2: 2Take1", "action", AngerFeatures.AngerSettingsFolder.id)
menu.add_feature("    3: Big Skull | 4: Small Skull", "action", AngerFeatures.AngerSettingsFolder.id)






----TESTING FEATURE
AngerFeatures.testing = menu.add_feature("Testing", "action", AngerFeatures.generalfolder.id, function(feature)
    if feature.on then
		--TESTING	

		--[[if player.is_player_vehicle_god(11) then
			LogToFile_AngerAnd2T1("yes godmode")
		else
			LogToFile_AngerAnd2T1("not godmode")
		end]]
		--get_Saved_Players_Data()
		--[[LogToFile_AngerAnd2T1("this guy RID is "..player.get_player_scid(7))  --get the RID when player left
		LogToFile_AngerAnd2T1("this guy ip is "..player.get_player_ip(7))         --get the ip=0 when player left
		if (player.get_player_name(7) ~= nil) then  
			LogToFile_AngerAnd2T1("this guy name is "..player.get_player_name(7)) --get name=nil when player left
		else
			LogToFile_AngerAnd2T1("this guy name is nil")
		end
		if (player.get_player_host_token(7) ~= nil) then
			LogToFile_AngerAnd2T1("this guy HT is "..player.get_player_host_token(7))--get HT=0 when player left
		else
			LogToFile_AngerAnd2T1("this guy HT is nil")
		end]]
		
		--LogToFile_AngerAnd2T1(tostring(entity.get_entity_speed(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())))))
		
		--[[local j 
		for i=0, 100000 do
			j=player.get_player_name(player.player_id())
		end]]
		
		--entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), v3(4700, 4700, 100))
		
		
		
		--[[local pid = 9
		
		if entity.is_entity_in_water(player.get_player_ped(pid)) then
			LogToFile_AngerAnd2T1("he in water")
		else
			LogToFile_AngerAnd2T1("he not in water")
		end
		
		if ped.is_ped_in_any_vehicle(player.get_player_ped(pid)) then
			LogToFile_AngerAnd2T1("he in any_vehicl")
		else
			LogToFile_AngerAnd2T1("he not in any_vehicl")
		end
		
		if ped.can_ped_ragdoll(player.get_player_ped(pid)) then
			LogToFile_AngerAnd2T1("he can ragdoll")
		else
			LogToFile_AngerAnd2T1("he not can ragdoll")
		end
		
		if entity.get_entity_coords(player.get_player_ped(pid)).x > 4500 then
			LogToFile_AngerAnd2T1("he above x 4800")
		else
			LogToFile_AngerAnd2T1("he not above x 4800")
		end
		
		if entity.get_entity_coords(player.get_player_ped(pid)).y > 4500 then
			LogToFile_AngerAnd2T1("he above y 4800")
		else
			LogToFile_AngerAnd2T1("he not above y 4800")
		end
		
		LogToFile_AngerAnd2T1(tostring(entity.get_entity_coords(player.get_player_ped(pid))))
		LogToFile_AngerAnd2T1(tostring(get_ped_last_weapon_impact(player.get_player_ped(pid))))]]
		
		
		--player.set_player_as_modder(3, modder_flags["Ang-Godmode-Aiming"])
		
		--LogToFile_AngerAnd2T1(tostring(round_to_integer(1200.752489)))
		
		
		
		--[[local P = v3(600,500,29.5)--player.get_player_coords(player.player_id())
		local Pa = v2(600,500)
		local Pb = v2(400,300)
		local Pc = v2(200,700)
		local Pd = v2(200,700)
		local quad_a = v2(600,500)
		local quad_b = v2(400,300)
		local quad_c = v2(200,700)
		local quad_d = v2(200,700)
		local z_max_altitude = 30
		local z_min_altitude = 29
		LogToFile_AngerAnd2T1(tostring(dist_2_point_in_2D_only(Pa, Pb)))  --282,84271247462
		
		LogToFile_AngerAnd2T1(tostring(area_triangle_3_point_in_2D_only(Pa, Pb, Pc)))  --60 000
		
		LogToFile_AngerAnd2T1(tostring(area_of_quadrilatere_in_2D_only(Pa, Pb, Pc, Pd)))  --60 000
		
		LogToFile_AngerAnd2T1(tostring(is_point_in_quadrilatere_2D_only(P, quad_a, quad_b, quad_c, quad_d, z_max_altitude, z_min_altitude)))
		
		LogToFile_AngerAnd2T1(tostring(is_point_in_quadrilatere_3D_only(P, quad_a, quad_b, quad_c, quad_d, z_max_altitude, z_min_altitude)))))
		
		
		--[[local pid = 0
		
		local pos = player.get_player_coords(pid)
		local lsia_quad_a = v2(-1600, -2700)
		local lsia_quad_b = v2(-700, -3100)
		local lsia_quad_c = v2(-1000, -3650)
		local lsia_quad_d = v2(-2000, -3100)
		local lsia_quad_z_max_altitude = 0
		local lsia_quad_z_min_altitude = -90
		local casino_quad_a = v2(1170, 283)
		local casino_quad_b = v2(977, -20)
		local casino_quad_c = v2(906, 15)
		local casino_quad_d = v2(1064, 256)
		local casino_quad_z_max_altitude = 50
		local casino_quad_z_min_altitude = -90
		
		if (pos.x > 4100 and pos.y < -4100)
		 or is_point_in_quadrilatere_3D_only(pos, lsia_quad_a, lsia_quad_b, lsia_quad_c, lsia_quad_d, lsia_quad_z_max_altitude, lsia_quad_z_min_altitude)
		 or is_point_in_quadrilatere_3D_only(pos, casino_quad_a, casino_quad_b, casino_quad_c, casino_quad_d, casino_quad_z_max_altitude, casino_quad_z_min_altitude)
		 --or ) ) add airport & casino (z_max_altitude > -90 & z_min_altitude < 1 both)
		then
			-----TESTING
			LogToFile_AngerAnd2T1(tostring(player.get_player_name(pid)).." is in not allowed area")
			-----TESTING
			return true
		else 
			-----TESTING
			LogToFile_AngerAnd2T1(tostring(player.get_player_name(pid)).." is in allowed area")
			-----TESTING
			return false
		end]]
		
		
		--[[local i = 7000
		menu.add_feature("test color", "toggle", 0, function(feature)
			
			while feature.on and i < 9000 do
				menu.notify("message + title + 2 seconds + green"..tostring(i), "title", 1, i)
				i=i+50
				system.yield(1100)
				
				plus c'est proche de zero plus c'est noir, plus on monte plus c'est rouge
				7000 trouge quiter
				 pour aller vers bleu 
				 puis orange fluo a 12000 tend vers brun  marron vers 16 17000
				 vers kaki 19000 ver tfonc� 210000 
				 orange 22500 tand vers brun
				 vert vers 30 000
				 orange 32500
				 vers fluo 37 000
				 42500 vert ultra fluo
				 jaune 45000
				 quez du ver apres ou orange fluo
				 
				   --0xF000: green?
				   --0x0F00: black?
				   --0x00F0: red?
				   --0x000F: red?
				   --0xFFFF: yellow ? o,0
			end
			
		end) --0x0000: black ]]
																			  
		
		
		--LogToFile_AngerAnd2T1(tostring(type(modder_flags)))
		--menu.notify("message", "title", 1--[[sec]], RGBA_to_int32_t(0,255,0,0))  --rgb(a)
		--Anger_notify("hello", RGBA_to_int32_t(0,255,0,255), 7)


		--[[local pos1kosatka = v3(1564.147,400.065,-47.511)
		local pos2kosatka = v3(1557.301,443.393,-50.646)
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos1kosatka)
		entity.set_entity_coords_no_offset(player.get_player_ped(player.player_id()), pos2kosatka)]]

		--[[local pid = 7
		LogToFile_AngerAnd2T1(tostring(is_player_in_area_considered_as_NOT_outside(pid)))]]

		--LogToFile_AngerAnd2T1(tostring(Anger_log_date()))


		--not good but it is an under approximation so good
		--LogToFile_AngerAnd2T1(tostring(speed_pid_2D_only(player.player_id())))
		--LogToFile_AngerAnd2T1(tostring(entity.get_entity_speed(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())))*3.6)) --31 on 2T1 overlay
		--LogToFile_AngerAnd2T1(tostring(entity.get_entity_speed(player.get_player_ped(player.player_id()))*3.6))
		--[[if speed_pid_2D_only(player.player_id()) > 8.61 then --31
			LogToFile_AngerAnd2T1(tostring("true"))
		else
			LogToFile_AngerAnd2T1(tostring("false"))
		end]]

		
		--LogToFile_AngerAnd2T1(tostring(type(utils.time_ms())))

		--[[local temp = AngerLib.lua_table.save(commands)
		LogToFile_AngerAnd2T1("test:"..tostring(temp))
		temp = AngerLib.lua_table.load(temp)
		LogToFile_AngerAnd2T1("test:"..tostring(temp.vehicle.subfunctions.launch.choices.all.help))]]

		--local pid = player.player_id()
		--LogToFile_AngerAnd2T1("test:"..tostring(is_player_ped_really_playing(pid, player.get_player_ped(pid))))
		--LogToFile_AngerAnd2T1("test:"..tostring(AngerLib.data.get_AI_task_id(array_AI_task_ids_telling_ped_loadingETC[7])))
		--LogToFile_AngerAnd2T1("test:"..tostring(array_AI_task_ids_telling_ped_loadingETC[7]))


		

		--Zeterg
		--LogToFile_AngerAnd2T1(tostring(tostring(string.find("-Kafky", "[^%w_-]+"))))
		--LogToFile_AngerAnd2T1(tostring(string.len( "-Kafky" )))set_vehicle_custom_primary_colour


		--LogToFile_AngerAnd2T1(tostring(script.get_global_i(1630317 + (1 + (pid * 595) + 506))))
		--send_SE(0--[[pid]], SE_hashes.bribe_cop[1])
		--[[send_SE(8, SE_hashes.notify[1])
		send_SE(8, SE_hashes.notify[2])
		send_SE(8, SE_hashes.notify[3])
		send_SE(8, SE_hashes.notify[4])
		send_SE(8, SE_hashes.notify[5])
		send_SE(8, SE_hashes.notify[6])
		send_SE(8, SE_hashes.notify[7])
		send_SE(8, SE_hashes.notify[8])
		send_SE(8, SE_hashes.notify[9])
		send_SE(8, SE_hashes.notify[10])
		send_SE(8, SE_hashes.notify[11])
		send_SE(8, SE_hashes.notify[12])
		send_SE(8, SE_hashes.notify[13])
		send_SE(8, SE_hashes.notify[14])
		send_SE(8, SE_hashes.notify[15])
		send_SE(8, SE_hashes.notify[16])]]
		
		--send_SE(3--[[pid]], SE_hashes.show_banner[1])

		--send to lobby bounty info
		--[[for i = 0, 31 do
					----event sent to pid, the_SE_data, value of bounty, target of bounty
			send_SE(i,          SE_hashes.anonymous_bounty[1],    1000 ,     3 )
		end]]


		--[[local pid = 1
		local _, z= gameplay.get_ground_z(v3(player.get_player_coords(pid).x, player.get_player_coords(pid).y, 0))
		teleport_player_vehicle_or_warn(pid, v3(-40, -40, z) , "offset", 
								true, "sms") ]]


		--LogToFile_AngerAnd2T1(tostring(vehicle.get_vehicle_custom_primary_colour(player.get_player_vehicle(player.player_id()))))



--[[		local Int_FEEDBACK, str_user_input = input.get("string title", "string default", 10, 2)
		LogToFile_AngerAnd2T1(tostring(Int_FEEDBACK)..":::::"..tostring(str_user_input))]]
		


		--[[LogToFile_AngerAnd2T1(tostring(get_user_input("test", "test", 10, int_INPUT_TYPES.ALPHA_NUM)))
		LogToFile_AngerAnd2T1(tostring("test done"))]]


		--AngerFunctions.LogToFile_AngerAnd2T1(tostring(AngerFunctions.get_user_input("test1", "default", 15, int_INPUT_TYPES.ALPHA_NUM)))
		
	end
end)
AngerFeatures.testing.hidden = true
----TESTING FEATURE

AngerFeatures.testingtoggle = menu.add_feature("Testing toggle", "toggle", AngerFeatures.generalfolder.id, function(feature)
    while feature.on do
		--send_SE(18, SE_hashes.vehicle_kick[1])
		AngerFunctions.send_SE(0, SE_hashes.crash[1])
		system.yield(50)
	end 
	--send_SE(0, SE_hashes.block_passive[1], false)
end)
--AngerFeatures.testingtoggle.hidden = true





--[[/***************************** USER SETTINGS MANAGMENT / SAVING / RETRIEVING**********************************************/]]


function AngerFunctions.save_settings() 
	AngerFunctions.rewrite_whole_file(AngerLib.lua_table.save(User_settings), path_SavedConfigINI)
	
	AngerFunctions.Anger_notify("Settings should be saved", AngerFunctions.RGBA_to_int32_t(0,255,0,255), 7)
end


function AngerFunctions.get_saved_settings()
	if utils.file_exists(path_SavedConfigINI) then

		local str = AngerFunctions.read_file_in_a_single_string(path_SavedConfigINI)
		
		local table_temp = AngerLib.lua_table.load(str)
		if AngerFunctions.table_or_array_Length(table_temp) <= AngerFunctions.table_or_array_Length(User_settings) then
			-------TESTING
			--LogToFile_AngerAnd2T1("same size")
			-------TESTING
			
			User_settings = table_temp
		else
			AngerFunctions.Anger_notify("Error Loading the saved settings :/", 0x0FF, 15)
		end
	end

	--Set Feature with toggle button State
	for key, value in pairs(AngerFeatures.with_toggle) do
		value.on = User_settings[key]
	end
	
	--Set Feature with value_input button data (not needed for now but surely in future)
	for key, value in pairs(AngerFeatures.with_value) do
		value.value = User_settings[key]
	end

end

AngerFunctions.get_saved_settings()


--Put it here to make ASCII_drawing below
Anger_loaded_version = Anger_loading_version


if User_settings["ASCII_drawing"] == 4 then
	for i = 0, AngerLib.ascii_art.get_max_length("ASCII_small_skull") do
		AngerFunctions.LogToFile_AngerAnd2T1(AngerLib.ascii_art.get_ASCII_art("ASCII_small_skull", i))
	end
	ASCII_Art_Not_Finished = false
	AngerFunctions.LogToFile_AngerAnd2T1("Anger "..Anger_loaded_version.." Loaded ")
	AngerFunctions.LogToFile_AngerAnd2T1("Have Fun! Good Luck.")

elseif User_settings["ASCII_drawing"] == 3 then
	local max = AngerLib.ascii_art.get_max_length("ASCII_big_skull")
	for i = 0, max do
		AngerFunctions.LogToFile_AngerAnd2T1(AngerLib.ascii_art.get_ASCII_art("ASCII_big_skull", i))
	end
	ASCII_Art_Not_Finished = false
	--[[NOT ENOUGH SPACE FOR BELOW LINES WITH BIG SKULL
	LogToFile_AngerAnd2T1("Anger "..Anger_loaded_version.." Loaded ")
	LogToFile_AngerAnd2T1("Have Fun! Good Luck.")]]
	
elseif User_settings["ASCII_drawing"] == 2 then
	for i = 0, AngerLib.ascii_art.get_max_length("ASCII_2T1") do
		AngerFunctions.LogToFile_AngerAnd2T1(AngerLib.ascii_art.get_ASCII_art("ASCII_2T1", i))
	end
	ASCII_Art_Not_Finished = false
	AngerFunctions.LogToFile_AngerAnd2T1("Anger "..Anger_loaded_version.." Loaded ")
	AngerFunctions.LogToFile_AngerAnd2T1("Have Fun! Good Luck.")
	
elseif User_settings["ASCII_drawing"] == 1 then
	for i = 0, AngerLib.ascii_art.get_max_length("ASCII_Anger") do
		AngerFunctions.LogToFile_AngerAnd2T1(AngerLib.ascii_art.get_ASCII_art("ASCII_Anger", i))
	end
	ASCII_Art_Not_Finished = false
	AngerFunctions.LogToFile_AngerAnd2T1("Anger "..Anger_loaded_version.." Loaded ")
	AngerFunctions.LogToFile_AngerAnd2T1("Have Fun! Good Luck.")
	
elseif User_settings["ASCII_drawing"] == 0 then  --no drawing
	ASCII_Art_Not_Finished = false
	AngerFunctions.LogToFile_AngerAnd2T1("Anger "..Anger_loaded_version.." Loaded ")
	AngerFunctions.LogToFile_AngerAnd2T1("Have Fun! Good Luck.")
end




--Default Event listening and function starting
--excpt get saved settings to have the good ASCI_art

--save_actual_players()
AngerFunctions.thread_Exit_Event_Listening()
AngerFunctions.thread_Join_Event_listening()
AngerFunctions.thread_Leave_Event_listening()
AngerFunctions.thread_Chat_listening()
menu.create_thread(AngerFunctions.thread_check_all_player_data_content, 0)
menu.create_thread(AngerFunctions.slow_thread, 0)
--AngerFunctions.display_chat_command_table_here(0)



AngerFunctions.Anger_notify("Anger "..Anger_loaded_version.." loaded! Enjoy ;)", AngerFunctions.RGBA_to_int32_t(0,255,255,255), 7)

