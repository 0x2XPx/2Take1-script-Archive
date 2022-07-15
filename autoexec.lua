local luaautoload = os.getenv("APPDATA") .. "\\PopstarDevs\\2Take1Menu\\scripts\\autoload\\"
local load_autoload_lua = debug.getinfo(1, "S").source:sub(luaautoload:len() + 2)

local autoload_lua_exclude = {
    load_autoload_lua,
    "test.lua",
    "testing.lua"
}

local exclusions = {}
for i = 1, #autoload_lua_exclude do
    exclusions[autoload_lua_exclude[i]] = true
end

local files = {}
for filename in io.popen('dir "' .. luaautoload .. '" /b'):lines() do
    if not exclusions[filename] and filename:sub(-4):lower() == ".lua" then
        table.insert(files, filename)
    end
end
for i = 1, #files do
    dofile(luaautoload .. files[i])
    ui.notify_above_map(files[i] .. " \n Auto Loaded from AutoLoad Folder", "Moist Auto LUA", 212)
end
