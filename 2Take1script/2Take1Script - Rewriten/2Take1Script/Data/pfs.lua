local path = {}
local file = {}
local shortcut = {}

local all = {
    path = path,
    file = file,
    shortcut = shortcut
}

path.pdevs = utils.get_appdata_path("PopstarDevs", "")
path.menu = path.pdevs .. "\\2Take1Menu"
path.dumps = path.menu .. "\\crashdump"
path.outfits = path.menu .. "\\moddedOutfits"
path.vehicles = path.menu .. "\\moddedVehicles"
path.scripts = path.menu .. "\\scripts"
path.autoload = path.scripts .. "\\autoload"
path._2t1s = path.scripts .. "\\2Take1Script"
path.config = path._2t1s .. "\\Config"
path.custom = path._2t1s .. "\\CustomFiles"
path.logger = path._2t1s .. "\\Event-Logger"

file.auth = path.pdevs .. "\\PopstarAuth.log"
file.menu_log = path.menu .. "\\2Take1Menu.log"
file.prep = path.menu .. "\\2Take1Prep.log"
file.dev = path._2t1s .. "\\2Take1Script-Dev.lua"
file.log = path._2t1s .. "\\2Take1Script.log"
file.chat = path._2t1s .. "\\2Take1Script-Chatlog.log"
file.ext = path.custom .. "\\2Take1Script-Extension.lua"
file.blacklist = path.custom .. "\\Blacklist.cfg"
file.modders = path.custom .. "\\ModderDB.cfg"
file.data = path.config .. "\\offsets.data"
file.config = path.config .. "\\2Take1Script.ini"
file.hotkeys = path.config .. "\\Hotkeys.ini"
file.exclude = path.config .. "\\MWHK-Exclude.ini"


shortcut.o = io.open
shortcut.navigate = menu.set_menu_can_navigate

shortcut.tn = tonumber
shortcut.ts = tostring

shortcut.wait = system.wait
shortcut.random = math.random

shortcut.time = utils.time_ms
shortcut.copy = utils.to_clipboard
shortcut.d_exists = utils.dir_exists
shortcut.f_exists = utils.file_exists

shortcut.id = player.player_id
shortcut.ped = player.get_player_ped
shortcut.valid = player.is_player_valid
shortcut.is_modder = player.is_player_modder
shortcut.set_modder = player.set_player_as_modder

shortcut.vehicle = ped.get_vehicle_ped_is_using

shortcut.god = entity.set_entity_god_mode
shortcut.gcoords = entity.get_entity_coords
shortcut.visible = entity.set_entity_visible
shortcut.attach = entity.attach_entity_to_entity

shortcut.explode = fire.add_explosion
shortcut.script = script.trigger_script_event
shortcut.unload = streaming.set_model_as_no_longer_needed

return all